require( "UI.SubscriptionUtils" )
require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5HintString = InheritFrom( LUI.UIElement )

function CoD.T5HintString.new( menu, controller )
    local self = LUI.UIElement.new()
    if PreLoadFunc then
        PreLoadFunc( menu, controller )
    end
    self:setClass(CoD.T5HintString)
    self.id = "T5HintString"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = false

    local scaleContainer = CoD.SplitscreenScaler.new( nil, 1.2 )
    scaleContainer:setLeftRight( true, true, 0.0, 0.0 )
    scaleContainer:setTopBottom( true, false, 0.0, 0.0 )
    
    self:addElement(scaleContainer)
    self.scaleContainer = scaleContainer


    local HintParent = LUI.UIElement.new()
    HintParent:setLeftRight( true, true, 0.0, 0.0 )
    HintParent:setTopBottom( true, false, 60.0, 100.0 )

    self.scaleContainer:addElement( HintParent )
    self.HintParent = HintParent


    local HintstringText = CoD.UIShadowText.new( menu, controller )
    HintstringText:setLeftRight( false, false, -125.0, 125.0 )
    HintstringText:setTopBottom( true, false, 0.0, 19.0 )
    HintstringText:setText( "" )
    HintstringText:setScale( 1.15 )
    HintstringText:setTTF( "fonts/helveticaneue.ttf" )
    
    self.HintParent:addElement(HintstringText)
    self.HintstringText = HintstringText


    local hintIcon = LUI.UIImage.new()
    hintIcon:setLeftRight(false, false, -32, 32) -- default to 2:1, 64x32
    hintIcon:setTopBottom(false, false, -16, 16)
    hintIcon:setImage( RegisterImage( "blacktransparent" ) )
    self.hintIcon = hintIcon
    self.HintParent:addElement(hintIcon)

    hintIcon:subscribeToGlobalModel( controller, "HUDItems", "cursorHintImage", function ( modelRef )
        local cursorHintImage = Engine.GetModelValue( modelRef )
        if cursorHintImage then
            
            hintIcon:setImage( RegisterImage( cursorHintImage ) )
        
            -- get the image dimensions
            local w, h = hintIcon:getImageDimensions()
            local scale = 64
            if w ~= nil and h ~= nil then
                if w < h then
                    scale = 64 / w
                else
                    scale = 64 / h
                end
                -- local aspectRatio = w/h
                hintIcon:setLeftRight(false, false, -w*0.5, w*0.5)
                hintIcon:setTopBottom(false, false, -h*0.5 + 32, h*0.5 + 32)
                hintIcon:setScale( scale )
            end

        end
    end )

    self.HintstringText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "HUDItems.cursorHintText" ) ), function( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            -- removes color from the string
            local Text = ModelValue:gsub( "%^%d", "" )
            self.HintstringText.Text:setText( Engine.Localize( ModelValue ) )
            self.HintstringText.TextShadow:setText( Engine.Localize( Text ) )
        end
    end )

    self.HintstringText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), ( "HUDItems.showCursorHint" ) ), function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            if ModelValue == true then
                self.HintParent:completeAnimation()
                self.HintParent:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                self.HintParent:setAlpha( 1.0 )

            else
                self.HintParent:completeAnimation()
                self.HintParent:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
                self.HintParent:setAlpha( 0.0 )

            end
        else
            self.HintParent:completeAnimation()
            self.HintParent:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
            self.HintParent:setAlpha( 0.0 )
        end
    end )

    self.StateTable = {
        {
            stateName = "Hidden",
            condition = function( menu, element, event )
                if ( Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ) or
                Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) ) then
                    return true
                else
                    return false
                end
            end
        }
    }

    self:mergeStateConditions( self.StateTable )

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                self.scaleContainer:completeAnimation()
                self.scaleContainer:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
                self.scaleContainer:setAlpha( 1.0 )
                self.scaleContainer:registerEventHandler( "transition_complete_keyframe", function( Sender, Event )
                    self.clipFinished( Sender, Event )
                end )
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                self.scaleContainer:completeAnimation()
                self.scaleContainer:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
                self.scaleContainer:setAlpha( 0.0 )
                self.scaleContainer:registerEventHandler( "transition_complete_keyframe", function( Sender, Event )
                    self.clipFinished( Sender, Event )
                end )
            end
        }
    }

    SubscribeToModelAndUpdateState( controller, menu, self, "HUDItems.playerSpawned" )
    SubscribeToModelAndUpdateState( controller, menu, self, "HUDItems.showCursorHint" )
    SubscribeToModelAndUpdateState( controller, menu, self, "HUDItems.cursorHintText" )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )

    if PostLoadFunc then
        PostLoadFunc( menu, controller )
    end
    
    return self
end