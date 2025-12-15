EXPORTS = {
    version = "1.0.0",
    DEBUG_MODE = false
};

function EXPORTS.outChat(...)
    if (EXPORTS.DEBUG_MODE) then
        sendInput(table.concat({ ... }, ", "));
    end
end

return EXPORTS;