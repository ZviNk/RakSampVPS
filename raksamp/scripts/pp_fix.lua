local ffi = require("ffi")

function onLoad()
    local ptr = ffi.cast('uint8_t*', 0x4D36AF)
    ptr[0] = 1
end

registerHandler('onScriptLoad', onLoad)