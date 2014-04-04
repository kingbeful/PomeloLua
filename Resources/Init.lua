-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end
cclog = function(...)
        print(string.format(...))
end

require "Json"

-- the game entry
local function main()
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    local Login = require "Login"
    Login:create()
end
xpcall(main, __G__TRACKBACK__)
