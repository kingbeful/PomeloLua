local M={}
-- create the UI
function M:create()
    local scene = CCScene:create()
    self.node = CCNode:create()
  
    local visibleSize = CCDirector:sharedDirector():getVisibleSize()
    local visibleOrigin = CCDirector:sharedDirector():getVisibleOrigin()

    local editBoxSize = CCSizeMake(visibleSize.width - 40, 64)
    local EditName = CCEditBox:create(editBoxSize, CCScale9Sprite:create("orange_edit.png"))
    EditName:setPosition(ccp(visibleOrigin.x+visibleSize.width/2, visibleOrigin.y+visibleSize.height*3/4))
    EditName:setAnchorPoint(ccp(0.5,0.5))
    
    EditName:setFontName("Paint Boy")
    EditName:setFontSize(48)
    EditName:setFontColor(ccc3(255,0,0))
    EditName:setPlaceHolder("Input your name")
    EditName:setPlaceholderFontColor(ccc3(255,255,255))
    
    EditName:setReturnType(kKeyboardReturnTypeDone)
    --EditName:registerScriptEditBoxHandler(editBoxTextEventHandle)
    self.node:addChild(EditName, 0, 10)

    local EditRoom = CCEditBox:create(editBoxSize, CCScale9Sprite:create("orange_edit.png"))
    EditRoom:setPosition(ccp(visibleOrigin.x+visibleSize.width/2, visibleOrigin.y+visibleSize.height/2))

    EditRoom:setFontName("Paint Boy")
    EditRoom:setFontSize(48)
    EditRoom:setFontColor(ccc3(255,0,0))
    EditRoom:setPlaceHolder("Input Room ID")
    EditRoom:setPlaceholderFontColor(ccc3(255,255,255))
    EditRoom:setReturnType(kKeyboardReturnTypeDone)
    self.node:addChild(EditRoom, 0, 11)
 
    local pBackgroundButton = CCScale9Sprite:create("green.png")
    local pBackgroundHighlightedButton = CCScale9Sprite:create("green.png")
    
    local pTitleButton = CCLabelTTF:create("Login", "Helvetica", 48)

    pTitleButton:setColor(ccc3(255,255,255))
    local pButton = CCControlButton:create(pTitleButton, pBackgroundButton)
    pButton:setBackgroundSpriteForState(pBackgroundHighlightedButton, CCControlStateHighlighted)
    pButton:setZoomOnTouchDown(true)
    pButton:setTitleColorForState(ccc3(159, 168, 176), CCControlStateHighlighted)
  
    pButton:setAnchorPoint(ccp(0.5, 0.5))
    pButton:setPosition(ccp(visibleOrigin.x+visibleSize.width/2, visibleOrigin.y+visibleSize.height/4))
    pButton:setPreferredSize(CCSizeMake(144, 72))
    self.node:addChild(pButton)
    local function touchDownAction(strEventName, pSender)
      local pControl = tolua.cast(pSender,"CCControlButton")
      local editName = tolua.cast(self.node:getChildByTag(10),"CCEditBox")
      local editRoom = tolua.cast(self.node:getChildByTag(11),"CCEditBox")
      self.name = editName:getText()
      self.rid = editRoom:getText()
      cclog("name = " .. self.name .. ", rid = "..self.rid)
      self:connectServer()
    end
    pButton:addHandleOfControlEvent(touchDownAction,CCControlEventTouchUpInside)

    scene:addChild(self.node)
    CCDirector:sharedDirector():runWithScene(scene)
end

function M:connectServer()
  local function onEvent(event, msg)
    cclog("event: ".. event .. " msg: " .. msg)
    if event == "gate.gateHandler.queryEntry" then
      local msgJson = json.decode(msg)
      PomeloClient:getInstance():disconnect()
      cclog("Host = ".. msgJson.host .. " port = " .. msgJson.port)
      
      PomeloClient:getInstance():connect(msgJson.host, msgJson.port)
      PomeloClient:getInstance():addListener("onChat")
      PomeloClient:getInstance():addListener("onAdd")
      PomeloClient:getInstance():addListener("onLeave")
      local data = {
          username = self.name,
          rid = self.rid
      }
      PomeloClient:getInstance():request("connector.entryHandler.enter", json.encode(data))
      --PomeloClient:getInstance():request("connector.entryHandler.enter", "{\"username\":\""..self.name.."\", \"rid\":\""..self.rid.."\"}")
    elseif event == "connector.entryHandler.enter" then
    elseif event == "onChat" then
      
    end
  end
  
  --PomeloClient:getInstance():connect("192.168.1.119", 3014)
  PomeloClient:getInstance():connect("192.168.1.217", 3014)
  PomeloClient:getInstance():registerScriptHandler(onEvent)
  local data = {
        uid = self.name
  }
  PomeloClient:getInstance():request("gate.gateHandler.queryEntry", json.encode(data))
  --PomeloClient:getInstance():request("gate.gateHandler.queryEntry", "{\"uid\":\"".. self.name .."\"}")
end

return M
