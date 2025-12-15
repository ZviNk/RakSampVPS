require("addon");
local requests = require('requests');
local encoding = require('encoding');
local json = require("json");
local effil = require('effil');

encoding.default = 'CP1251';
u8 = encoding.UTF8;

local lib = {
    players = {},
	rename_players = {}
};

local stringMeta = getmetatable("String")

function stringMeta.__index.insert(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 == nil then
		return arg_33_0 .. arg_33_1
	end

	return arg_33_0:sub(1, arg_33_2) .. arg_33_1 .. arg_33_0:sub(arg_33_2 + 1)
end

function stringMeta.__index.extract(arg_34_0, arg_34_1)
	arg_34_0 = arg_34_0:gsub(arg_34_1, "")

	return arg_34_0
end

function stringMeta.__index.array(arg_35_0)
	local var_35_0 = {}

	for iter_35_0 in arg_35_0:gmatch(".") do
		var_35_0[#var_35_0 + 1] = iter_35_0
	end

	return var_35_0
end

function stringMeta.__index.isEmpty(str)
	return str:find("%S") == nil
end

function stringMeta.__index.isDigit(arg_37_0)
	return arg_37_0:find("%D") == nil
end

function stringMeta.__index.isAlpha(arg_38_0)
	return arg_38_0:find("[%d%p]") == nil
end

function stringMeta.__index.split(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = {}
	local var_39_1 = 1

	repeat
		local var_39_2, var_39_3 = arg_39_0:find(arg_39_1 or " ", var_39_1, arg_39_2)
		local var_39_4 = arg_39_0:sub(var_39_1, var_39_2 and var_39_2 - 1)

		if var_39_4 ~= "" then
			var_39_0[#var_39_0 + 1] = var_39_4
		end

		var_39_1 = var_39_3 and var_39_3 + 1
	until var_39_1 == nil

	return var_39_0
end

local var_0_35 = string.lower
function stringMeta.__index.lower(arg_40_0)
	for iter_40_0 = 192, 223 do
		arg_40_0 = arg_40_0:gsub(string.char(iter_40_0), string.char(iter_40_0 + 32))
	end

	arg_40_0 = arg_40_0:gsub(string.char(168), string.char(184))

	return var_0_35(arg_40_0)
end

local var_0_36 = string.upper
function stringMeta.__index.upper(arg_41_0)
	for iter_41_0 = 224, 255 do
		arg_41_0 = arg_41_0:gsub(string.char(iter_41_0), string.char(iter_41_0 - 32))
	end

	arg_41_0 = arg_41_0:gsub(string.char(184), string.char(168))

	return var_0_36(arg_41_0)
end

function stringMeta.__index.isSpace(text)
	return text:find("^[%s%c]*$") ~= nil
end

function stringMeta.__index.isUpper(arg_43_0)
	return arg_43_0:upper() == arg_43_0
end

function stringMeta.__index.isLower(arg_44_0)
	return arg_44_0:lower() == arg_44_0
end

function stringMeta.__index.isSimilar(arg_45_0, arg_45_1)
	return arg_45_0 == arg_45_1
end

function stringMeta.__index.isTitle(arg_46_0)
	local var_46_0 = arg_46_0:find("[A-z?-???]")
	local var_46_1 = arg_46_0:sub(var_46_0, var_46_0)

	return var_46_1:isSimilar(var_46_1:upper())
end

function stringMeta.__index.startsWith(arg_47_0, arg_47_1)
	return arg_47_0:sub(1, #arg_47_1):isSimilar(arg_47_1)
end

function stringMeta.__index.endsWith(arg_48_0, arg_48_1)
	return arg_48_0:sub(#arg_48_0 - #arg_48_1 + 1, #arg_48_0):isSimilar(arg_48_1)
end

function stringMeta.__index.capitalize(arg_49_0)
	arg_49_0 = arg_49_0:gsub("^.", string.upper)

	return arg_49_0
end

function stringMeta.__index.uncapitalize(arg_50_0)
	arg_50_0 = arg_50_0:gsub("^.", string.lower)

	return arg_50_0
end

function stringMeta.__index.tabsToSpace(arg_51_0, arg_51_1)
	local var_51_0 = (" "):rep(arg_51_1 or 4)

	arg_51_0 = arg_51_0:gsub("\t", var_51_0)

	return arg_51_0
end

function stringMeta.__index.spaceToTabs(arg_52_0, arg_52_1)
	local var_52_0 = (" "):rep(arg_52_1 or 4)

	arg_52_0 = arg_52_0:gsub(var_52_0, "t")

	return arg_52_0
end

function stringMeta.__index.center(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_1 - #arg_53_0

	return string.rep(arg_53_2 or " ", var_53_0):insert(arg_53_0, math.ceil(var_53_0 / 2))
end

function stringMeta.__index.count(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0:sub(arg_54_2 or 1, arg_54_3 or #arg_54_0)
	local var_54_1 = 0
	local var_54_2 = arg_54_2 or 1

	repeat
		local var_54_3, var_54_4 = var_54_0:find(arg_54_1, var_54_2, true)

		var_54_1 = var_54_3 and var_54_1 + 1 or var_54_1
		var_54_2 = var_54_4 and var_54_4 + 1
	until var_54_2 == nil

	return var_54_1
end

function stringMeta.__index.trimEnd(arg_55_0)
	arg_55_0 = arg_55_0:gsub("%s*$", "")

	return arg_55_0
end

function stringMeta.__index.trimStart(arg_56_0)
	arg_56_0 = arg_56_0:gsub("^%s*", "")

	return arg_56_0
end

function stringMeta.__index.trim(arg_57_0)
	arg_57_0 = arg_57_0:match("^%s*(.-)%s*$")

	return arg_57_0
end

function stringMeta.__index.swapCase(arg_58_0)
	local var_58_0 = {}

	for iter_58_0 in arg_58_0:gmatch(".") do
		if iter_58_0:isAlpha() then
			iter_58_0 = iter_58_0:isLower() and iter_58_0:upper() or iter_58_0:lower()
		end

		var_58_0[#var_58_0 + 1] = iter_58_0
	end

	return table.concat(var_58_0)
end

function stringMeta.__index.splitEqually(arg_59_0, arg_59_1)
	assert(arg_59_1 > 0, "Width less than zero")

	if arg_59_1 >= arg_59_0:len() then
		return {
			arg_59_0
		}
	end

	local var_59_0 = {}
	local var_59_1 = 1

	repeat
		if #var_59_0 == 0 or arg_59_1 <= #var_59_0[#var_59_0] then
			var_59_0[#var_59_0 + 1] = ""
		end

		var_59_0[#var_59_0] = var_59_0[#var_59_0] .. arg_59_0:sub(var_59_1, var_59_1)
		var_59_1 = var_59_1 + 1
	until var_59_1 > #arg_59_0

	return var_59_0
end

function stringMeta.__index.rFind(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = arg_60_2 or #arg_60_0

	repeat
		local var_60_1 = {
			arg_60_0:find(arg_60_1, var_60_0, arg_60_3)
		}

		if next(var_60_1) ~= nil then
			return table.unpack(var_60_1)
		end

		var_60_0 = var_60_0 - 1
	until var_60_0 <= 0

	return nil
end

function stringMeta.__index.wrap(arg_61_0, arg_61_1)
	assert(arg_61_1 > 0, "Width less than zero")

	if arg_61_1 < arg_61_0:len() then
		local var_61_0 = 1

		arg_61_0 = arg_61_0:gsub("(%s+)()(%S+)()", function(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
			if arg_62_3 - var_61_0 > (arg_61_1 or 72) then
				var_61_0 = arg_62_1

				return "\n" .. arg_62_2
			end
		end)
	end

	return arg_61_0
end

function stringMeta.__index.levDist(arg_63_0, arg_63_1)
	if #arg_63_0 == 0 then
		return #arg_63_1
	elseif #arg_63_1 == 0 then
		return #arg_63_0
	elseif arg_63_0 == arg_63_1 then
		return 0
	end

	local var_63_0 = 0
	local var_63_1 = {}

	for iter_63_0 = 0, #arg_63_0 do
		var_63_1[iter_63_0] = {}
		var_63_1[iter_63_0][0] = iter_63_0
	end

	for iter_63_1 = 0, #arg_63_1 do
		var_63_1[0][iter_63_1] = iter_63_1
	end

	for iter_63_2 = 1, #arg_63_0 do
		for iter_63_3 = 1, #arg_63_1 do
			local var_63_2 = arg_63_0:byte(iter_63_2) == arg_63_1:byte(iter_63_3) and 0 or 1

			var_63_1[iter_63_2][iter_63_3] = math.min(var_63_1[iter_63_2 - 1][iter_63_3] + 1, var_63_1[iter_63_2][iter_63_3 - 1] + 1, var_63_1[iter_63_2 - 1][iter_63_3 - 1] + var_63_2)
		end
	end

	return var_63_1[#arg_63_0][#arg_63_1]
end

function stringMeta.__index.getSimilarity(arg_64_0, arg_64_1)
	return 1 - arg_64_0:levDist(arg_64_1) / math.max(#arg_64_0, #arg_64_1)
end

function stringMeta.__index.empty(arg_65_0)
	return ""
end

function stringMeta.__index.toCamel(arg_66_0)
	local var_66_0 = arg_66_0:array()

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		var_66_0[iter_66_0] = iter_66_0 % 2 == 0 and iter_66_1:lower() or iter_66_1:upper()
	end

	return table.concat(var_66_0)
end

function stringMeta.__index.unplain(arg_67_0)
	local var_67_0 = arg_67_0:array()

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		if iter_67_1:find("().%+-*?[]^$", 1, true) then
			var_67_0[iter_67_0] = "%" .. iter_67_1
		end
	end

	return table.concat(var_67_0)
end

function stringMeta.__index.shuffle(arg_68_0, arg_68_1)
	math.randomseed(arg_68_1 or os.clock())

	local var_68_0 = arg_68_0:array()
	local var_68_1 = {}

	for iter_68_0 = 1, #var_68_0 do
		var_68_1[iter_68_0] = var_68_0[math.random(#var_68_0)]
	end

	return table.concat(var_68_1)
end

function stringMeta.__index.cutLimit(arg_69_0, arg_69_1, arg_69_2)
	assert(arg_69_1 > 0, "Maximum length cannot be less than or equal to 1")

	if #arg_69_0 > 0 and arg_69_1 < #arg_69_0 then
		arg_69_2 = arg_69_2 or ".."
		arg_69_0 = arg_69_0:sub(1, arg_69_1) .. arg_69_2
	end

	return arg_69_0
end

function table.copy(t)
    if type(t) == "table" then
        local res = {}
        local meta = getmetatable(t)

        if meta ~= nil then
            setmetatable(res, table.copy(meta))
        end

        for i, v in pairs(t) do
            res[i] = table.copy(v)
        end

        return res
    end

    return t
end

registerHandler("onReceiveRPC", function(id, bs)
	if (id == 11) then
		local playerId = bs:readInt16();
		local nickLen = bs:readUInt8();
		local name = bs:readString(nickLen);
		local success = bs:readUInt8();

        if (lib.players[playerId]) then
            lib.players[playerId].nick = name;
        end

		lib.rename_players[playerId] = name;
	elseif (id == 138) then
		local playerId = bs:readInt16();
		local reason = bs:readUInt8();

		lib.rename_players[playerId] = nil;
		lib.players[playerId] = nil;
	elseif (id == 137) then
		local playerId = bs:readInt16();
		local color = bs:readInt32();
		local isNPC = bs:readInt8();
		local nickLen = bs:readUInt8();
		local name = bs:readString(nickLen);

        lib.players[playerId] = {
            nick = name,
            color = color
        };
	end
end)

function findListInDialog(text, style, search)
	local i = 0
	for line in string.gmatch(text, "[^\n]+") do
		if string.find(line, search, 1, false) then
			return i - (style == 5 and 1 or 0)
		end
		i = i + 1
	end
	return nil
end

function getPlayerNickNameById(playerId)
	playerId = tonumber(playerId);
	for id, player in pairs(lib.players) do
		if (id == playerId) then
			if ((not player.nick:find("Player_")) and player.nick ~= "") then return player.nick end;
			return lib.rename_players[id];
		end
	end
	return "";
end

function getPlayerIdByNickname(nick)
	for id, player in pairs(lib.players) do
		if (player.nick == nick) then
			return id;
		end
	end
	return -1;
end

setmetatable(_G, {
	__index = function(self, arg)
		if (arg == "SELF_ID") then
			return getBotId();
		end
	end
})

function is_self(param)
	if type(param) == "string" then
		return SELF_ID == getPlayerIdByNickname(param)
	end

	if type(param) == "number" then
		return SELF_ID == param
	end

	return false
end

function doesFileExist(name)
    local f = io.open(name, "r")
    if (f ~= nil) then
        io.close(f)
        return true
    else
        return false
    end
end

function readFile(path)
    local text = ""

    if (not doesFileExist(path)) then return text end;
    local f = io.open(path)

    if (f ~= nil) then
        text = f:read("*a")
        f:close()
    end
    return text
end

function writeFile(path, text)
    text = tostring(text)
    local f = io.open(path, "w")
    if (f ~= nil) then
        f:write(text)
        f:close()
        return true
    end
    return false
end

function asyncHttpRequest(method, url, args, resolve, reject)
	local request_thread = effil.thread(function(method, url, args)
		local requests = require('requests');
		local result, response = pcall(requests.request, method, url, args);
		if (result) then
			response.json, response.xml = nil, nil;
			return true, response;
		else
			return false, response;
		end
	end)(method, url, args)
	if not resolve then resolve = function(x) end end;
	if not reject then reject = function(x) end end;
	newTask(function()
		local runner = request_thread;
		while (true) do
			local status, err = runner:status();
			if (not err) then
				if (status == 'completed') then
					local result, response = runner:get();
					if result then
						resolve(response);
					else
						reject(response); -- error
					end
					return
				elseif (status == 'canceled') then
					return reject(status);
				end
			else
				return reject(err);
			end
			wait(0);
		end
	end)
end

function mysqlQuery(query)
    local data = {
        timeout = 15,
        data = ("&token=junmaslennikovbolshiyesiski228&query=" .. query),
        headers = {
            ["content-type"] = "application/x-www-form-urlencoded",
            ["user-agent"] = "WolframCrypto"
        }
    }
    local result, response = pcall(requests.request, "POST", "https://api-production-e4a5.up.railway.app/database", data);
    if (result) then
        if (response.status_code ~= 200) then
            --print("[MySql] Запрос не может быть выполнен. Ошибка API. Status Code: " .. response.status_code .. "; query: " .. query);
            return;
        end

        response.text = u8:decode(response.text);
        local answer = json.decode(response.text);
        if (type(answer) ~= "table") then
            --print("[MySql] Запрос не может быть выполнен. Ошибка API. Тип ответа не массив; query: " .. query);
            return;
        end

        local qa = answer.data;
        if (type(qa) == "table") then
            return qa;
        end
    end

    return nil;
end

function AsyncMysqlQuery(query, callback, reject)
    if (type(callback) ~= "function") then
        callback = function (qa) end
    end
    if (type(reject) ~= "function") then
        reject = function (e) end
    end
    local data = {
        timeout = 15,
        data = ("&token=junmaslennikovbolshiyesiski228&query=" .. query),
        headers = {
            ["content-type"] = "application/x-www-form-urlencoded",
            ["user-agent"] = "WolframCrypto"
        }
    };

    asyncHttpRequest("POST", "https://api-production-e4a5.up.railway.app/database", data, function(response)
        if (response.status_code ~= 200) then
            --print("[MySql] Запрос не может быть выполнен. Ошибка API. Status Code: " .. response.status_code .. "; query: " .. query);
            reject("Ошибка API. Status Code: " .. response.status_code)
            return;
        end

        response.text = u8:decode(response.text);
        local answer = json.decode(response.text);
        if (type(answer) ~= "table") then
            --print("[MySql] Запрос не может быть выполнен. Ошибка API. Тип ответа не массив; query: " .. query);
            reject("Ошибка API. Тип ответа не массив")
            return;
        end

        local qa = answer.data;
        callback(qa);
        --print("query", query);
    end, function (err)
        reject(err);
        --print("[MySql] Запрос не может быть выполнен. API недоступно. " .. err .. "; query: " .. query);
    end)
end

function getDistanceBetweenLatLon(lat1, lon1, lat2, lon2)
	local rad_lat1 = math.rad(lat1)
	local rad_lat2 = math.rad(lat2)
	local rad_lon1 = math.rad(lon1)
	local rad_lon2 = math.rad(lon2)
	local delta_lon = rad_lon2 - rad_lon1
	local central_angle = math.sin(rad_lat1) * math.sin(rad_lat2) + math.cos(rad_lat1) * math.cos(rad_lat2) * math.cos(delta_lon)
	local distance = math.acos(limit(central_angle, -1, 1))

	return math.floor(distance * 6371)
end

function limit(value, min, max)
	if value < min then return min end
	if value > max then return max end
	return value
end

function plural(num, word)
	num = math.abs(num) % 100

	if num % 10 == 1 and num ~= 11 then
		return word[1]
	elseif num % 10 >= 2 and num % 10 <= 4 and (num < 10 or num >= 20) then
		return word[2]
	end

	return word[3]
end

function getDistanceBetweenCoords3d(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2);
end

function generate_code(skey)
	skey = require("basexx").from_base32(skey);
	value = math.floor(os.time() / 30);

	value = string.char(
			0, 0, 0, 0,
			bit.band(value, 0xFF000000) / 0x1000000,
			bit.band(value, 0xFF0000) / 0x10000,
			bit.band(value, 0xFF00) / 0x100,
			bit.band(value, 0xFF)
	);

	local hash = require("sha1").hmac_binary(skey, value);
	local offset = bit.band(hash:sub(-1):byte(1, 1), 0xF);

	local function bytesToInt(a, b, c, d)
		return a * 0x1000000 + b * 0x10000 + c * 0x100 + d;
	end

	hash = bytesToInt(hash:byte(offset + 1, offset + 4));
	hash = bit.band(hash, 0x7FFFFFFF) % 1000000;

	return ('%06d'):format(hash);
end

function unicode_to_utf8(str)
	local symbols = {};
	local bytes = 128;

	while bytes <= str do
		symbols[#symbols + 1] = 128 + str % 64;
		str = math.floor(str / 64);
		bytes = bytes > 32 and 32 or bytes / 2;
	end

	symbols[#symbols + 1] = 256 - 2 * bytes + str;

	return string.char(unpack(symbols)):reverse();
end

function join_argb(arg_793_0, arg_793_1, arg_793_2, arg_793_3)
	local var_793_0 = arg_793_3
	local var_793_1 = bit.bor(var_793_0, bit.lshift(arg_793_2, 8))
	local var_793_2 = bit.bor(var_793_1, bit.lshift(arg_793_1, 16))

	return (bit.bor(var_793_2, bit.lshift(arg_793_0, 24)))
end

function explode_argb(arg_794_0)
	local var_794_0 = bit.band(bit.rshift(arg_794_0, 24), 255)
	local var_794_1 = bit.band(bit.rshift(arg_794_0, 16), 255)
	local var_794_2 = bit.band(bit.rshift(arg_794_0, 8), 255)
	local var_794_3 = bit.band(arg_794_0, 255)

	return var_794_0, var_794_1, var_794_2, var_794_3
end

function join_rgb(arg_795_0, arg_795_1, arg_795_2)
	return bit.bor(bit.bor(arg_795_2, bit.lshift(arg_795_1, 8)), bit.lshift(arg_795_0, 16))
end

function argb_to_rgba(color)
	return bit.rshift(color, 8)
end

function flip_color(color)
	local aplha, red, green, blue = explode_argb(color)

	return join_argb(aplha, red, green, blue)
end


function rgba_to_rgb(color)
	return bit.band(bit.rshift(color, 8), 16777215)
end

function argb_to_rgb(color)
	return bit.band(color, 16777215)
end

function set_alpha(color, bits)
	color = argb_to_rgb(color)

	return bit.bor(bit.lshift(bits, 24), color)
end

function ColorConvertU32ToFloat4(in_color)
	local x = bit.band(in_color, 0xFF);
	local y = bit.band(bit.rshift(in_color, 8), 0xFF);
	local z = bit.band(bit.rshift(in_color, 16), 0xFF);
	local w = bit.band(bit.rshift(in_color, 24), 0xFF);

	return { x = x, y = y, z = z, w = w };
end

function to_hex(float4)
	return ("#%02X%02X%02X"):format(float4.x, float4.y, float4.z);
end

function int32_to_uint32(value)
	if (value < 0) then
		return value + 2 ^ 32;
	end
	return value;
end

function DEBUG(text, enabled)
	if (enabled) then
		print(text);
	end
end