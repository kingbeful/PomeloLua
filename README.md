PomeloLua
==================
PomeloLua shows how to use pomelo in coco2dx lua.
It is based on [libpomelo](https://github.com/NetEase/libpomelo) and can be used by [cocos2d-x](https://github.com/cocos2d/cocos2d-x) in Lua
The server side is [chatofpomelo-websocket](https://github.com/NetEase/chatofpomelo-websocket).

##iOS

* Build the library of libpomelo for iOS or iOS simulator. 
* Copy the compiled library folder to cocos2dx project
* Configure cocos2dx project (Assume LIBPOMELO_ROOT is "$(SRCROOT)/../libpomelo")
	* Add include path: 
      LIBPOMELO_ROOT/include (example: "$(SRCROOT)/../libpomelo/include")
      LIBPOMELO_ROOT/deps/uv/include (example: "$(SRCROOT)/../libpomelo/deps/uv/include")
      LIBPOMELO_ROOT/deps/jansson/src (example: "$(SRCROOT)/../libpomelo/deps/jansson/src")
      to Header Search Paths of project.
	* Add library path: 
      LIBPOMELO_ROOT/build/Default-iphoneos 
      (example: "$(SRCROOT)/../libpomelo/build/Default-iphoneos")
      LIBPOMELO_ROOT/deps/uv/build/Default-iphoneos
      (example: "$(SRCROOT)/../libpomelo/deps/uv/build/Default-iphoneos")
      LIBPOMELO_ROOT/deps/jansson/build/Default-iphoneos
      (example: "$(SRCROOT)/../libpomelo/deps/jansson/build/Default-iphoneos")
      to the Library Search Paths of project. 
	* Add linker flags: 
      -ljansson
      -luv
      -lpomelo
      to the Other Linker Flags of project.

##Android

TBC

###Connect to server

``` lua
  PomeloClient:getInstance():connect("192.168.1.217", 3014)
```

###Register Lua Handler

``` lua
  local function onEvent(event, msg)
    print("event: ".. event .. " msg: " .. msg)
  end
  PomeloClient:getInstance():registerScriptHandler(onEvent)
```

###Add Listener

``` lua
  PomeloClient:getInstance():addListener("onChat")
```

###Remove Listener

``` lua
  PomeloClient:getInstance():removeListener("onChat")
```

###Send Request

``` lua
  PomeloClient:getInstance():request("gate.gateHandler.queryEntry", json.encode(data))
```

###Send Notify

``` lua
  PomeloClient:getInstance():notify("gate.gateHandler.queryEntry", json.encode(data))
```

##License

The MIT License (MIT)

Copyright (c) 2014 Kevin Qian and other contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
