--------------------------------------------------------------
-- LETTERBOXBORDER -------------------------------------------
 
-- Blocks out the original screen resolution for devices with a different aspect ratio.
-- Note it is designed to work for apps with scale mode of "letterbox".
-- As a result it is impossible that both the screenOriginX and screenOriginY ~= 0, only 1 can be
-- This should always be the last thing called if used, so that it goes on top of anything else,
--   although if borders are created, it returns a display group containing the bars, so you can use
--   this later with :toFront() should it be needed.
function letterboxBorder(params)
 
    -- Missed parameters
    if not params.r then params.r = 0; end
    if not params.g then params.g = 0; end
    if not params.b then params.b = 0; end
    
    -- Use display resolution information to block out areas if needed - makes the letter box thing nicer
    -- Should probably use images in the future...
    if display.screenOriginX ~= 0 then
        local group = display.newGroup()
        
        local leftBar = display.newRect(0, 0, -display.screenOriginX, display.contentHeight)
            leftBar:setFillColor(params.r, params.g, params.b)
        leftBar.x     = display.screenOriginX * 0.5
        group:insert(leftBar)
        
        local rightBar = display.newRect(0, 0, -display.screenOriginX, display.contentHeight)
        rightBar:setFillColor(params.r, params.g, params.b)
            rightBar.x     = display.contentWidth - display.screenOriginX * 0.5
        group:insert(rightBar)
 
        return group
        
    elseif displayscreenOriginY ~= 0 then
        local group = display.newGroup()
        
        local topBar = display.newRect(0, 0, display.contentWidth, -display.screenOriginY)
            topBar:setFillColor(params.r, params.g, params.b)
        topBar.y     = display.screenOriginY * 0.5
        group:insert(topBar)
 
        local bottomBar = display.newRect(0, 0, display.contentWidth, -display.screenOriginY)
            bottomBar:setFillColor(params.r, params.g, params.b)
        bottomBar.y     = display.contentHeight - display.screenOriginY * 0.5
        group:insert(bottomBar)
 
        return group
    end
 
    -- Desired screen resolution fills the device's screen
    return false
    
end