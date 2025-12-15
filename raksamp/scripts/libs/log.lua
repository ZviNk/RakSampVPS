-- log.lua (modified)
local log = { _version = "0.1.1" }

log.usecolor = true
log.outfile = os.getenv("LOGFILE") or nil   -- поддержка переменной окружения
log.level = os.getenv("LOGLEVEL") or "trace"

local modes = {
  { name = "trace", color = "\27[34m", },
  { name = "debug", color = "\27[36m", },
  { name = "info",  color = "\27[32m", },
  { name = "warn",  color = "\27[33m", },
  { name = "error", color = "\27[31m", },
  { name = "fatal", color = "\27[35m", },
}

local levels = {}
for i, v in ipairs(modes) do
  levels[v.name] = i
end

local round = function(x, increment)
  increment = increment or 1
  x = x / increment
  return (x > 0 and math.floor(x + .5) or math.ceil(x - .5)) * increment
end

local _tostring = tostring

local tostring = function(...)
  local t = {}
  for i = 1, select('#', ...) do
    local x = select(i, ...)
    if type(x) == "number" then
      x = round(x, .01)
    end
    t[#t + 1] = _tostring(x)
  end
  return table.concat(t, " ")
end

-- внутренний файловый дескриптор (если задан logfile)
local file_handle = nil
local function open_logfile_once()
  if log.outfile and not file_handle then
    local ok, fp = pcall(io.open, log.outfile, "a")
    if ok and fp then
      file_handle = fp
    else
      -- не удалось открыть, сбрасываем outfile и пишем предупреждение в stdout
      file_handle = nil
      log.outfile = nil
      io.stdout:write(("WARN: не удалось открыть файл лога '%s'\n"):format(tostring(os.getenv("LOGFILE") or log.outfile)))
      io.stdout:flush()
    end
  end
end

for i, x in ipairs(modes) do
  local nameupper = x.name:upper()
  log[x.name] = function(...)
    if i < levels[log.level] then
      return
    end

    local msg = tostring(...)
    local info = debug.getinfo(2, "Sl")
    local lineinfo = (info and info.short_src or "?") .. ":" .. (info and info.currentline or "?")

    -- Формируем строку для консоли и файла
    local console_line = string.format("%s[%-6s%s]%s %s: %s\n",
                        log.usecolor and x.color or "",
                        nameupper,
                        os.date("%H:%M:%S"),
                        log.usecolor and "\27[0m" or "",
                        lineinfo,
                        msg)

    local file_line = string.format("[%-6s%s] %s: %s\n",
                                nameupper, os.date(), lineinfo, msg)

    -- Немедленно пишем в stdout и сбрасываем буфер
    io.stdout:write(console_line)
    io.stdout:flush()

    -- Пишем в файл, если задан
    if log.outfile then
      open_logfile_once()
      if file_handle then
        file_handle:write(file_line)
        file_handle:flush()
      end
    end
  end
end

-- Функция для корректного закрытия файла (если приложение завершает работу аккуратно)
function log.close()
  if file_handle then
    pcall(function() file_handle:close() end)
    file_handle = nil
  end
end

return log
