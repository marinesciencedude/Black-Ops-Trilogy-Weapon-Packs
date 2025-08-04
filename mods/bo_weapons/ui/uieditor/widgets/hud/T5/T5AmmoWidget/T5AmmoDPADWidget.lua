require( "ui.uieditor.widgets.hud.T5.UIShadowText" )
require( "ui.uieditor.widgets.hud.T5.T5AmmoWidget.T5AmmoDPADCoverWidget" )

-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

CoD.T5AmmoDPADWidget = InheritFrom( LUI.UIElement )
CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_NONE = 0
CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_40MM = 1
CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_MASTERKEY = 2
CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_FLAMETHROWER = 3

local PreLoadFunc = function ( self, controller )
    local model = Engine.GetModelForController( controller )
    self:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "fastRestart" ), function ( modelRef )
        Engine.SetModelValue( Engine.CreateModel( model, "hudItems.actionSlot3ammo" ), 0 )
        Engine.SetModelValue( Engine.CreateModel( model, "hudItems.actionSlot4ammo" ), 0 )
    end, false )
    Engine.SetModelValue( Engine.CreateModel( model, "hudItems.actionSlot3ammo" ), 0 )
    Engine.SetModelValue( Engine.CreateModel( model, "hudItems.actionSlot4ammo" ), 0 )
end

function CoD.T5AmmoDPADWidget.new( menu, controller )
	local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.T5AmmoDPADWidget )
    self.id = "T5AmmoDPADWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true

    local DPADParent = LUI.UIElement.new()
    DPADParent:setLeftRight( true, true, 0, 0 )
    DPADParent:setTopBottom( true, true, 0, 0 )

    self:addElement( DPADParent )
    self.DPADParent = DPADParent


    -- dpad covers--------------------------------------------------------------------------------------------------------------
    local DPADCoverTop = CoD.T5AmmoDPADCoverWidget.new( menu, controller )
    DPADCoverTop:setLeftRight( true, true, 0, 0 )
    DPADCoverTop:setTopBottom( true, true, 50, -50 )
    DPADCoverTop:setElementRotation( 0 )
    DPADCoverTop:setElementBind( "[{+actionslot 1}]" )
    DPADCoverTop.DPADImage:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_saturation_normal" ) )

    self:addElement( DPADCoverTop )
    self.DPADCoverTop = DPADCoverTop

    self.DPADCoverTop:subscribeToGlobalModel( controller, "PerController", "bgb_current", function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            self.DPADCoverTop.DPADImage:setImage( RegisterImage( GetItemImageFromIndex( ModelValue ) ) )
            self.DPADCoverTop.DPADImageCustom:setImage( RegisterImage( GetItemImageFromIndex( ModelValue ) ) )
        end
    end )

    self.DPADCoverTop:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )

        if ModelValue then

            if ModelValue == 1 then
                self.DPADCoverTop.DPADImageCustom:setAlpha( 0 )
                self.DPADCoverTop.DPADImage:setShaderVector( 0, 1, 0, 0, 0 )
            else
                self.DPADCoverTop.DPADImageCustom:setAlpha( 1 )
                self.DPADCoverTop.DPADImage:setShaderVector( 0, 0, 0, 0, 0 )
            end

            local shaderW = CoD.GetVectorComponentFromString( ModelValue, 1 )
            local shaderX = CoD.GetVectorComponentFromString( ModelValue, 2 )
            local shaderY = CoD.GetVectorComponentFromString( ModelValue, 3 )
            local shaderZ = CoD.GetVectorComponentFromString( ModelValue, 4 )

            self.DPADCoverTop.DPADImageCustom:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
            self.DPADCoverTop.DPADImageCustom:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 1, ScaleVector( 1, shaderW, shaderX, shaderY, shaderZ ) ) ) )
            self.DPADCoverTop.DPADImageCustom:registerEventHandler( "transition_complete_keyframe", nil )
        end
    end )

    self.DPADCoverTop:subscribeToGlobalModel( controller, "PerController", "bgb_display", function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue == 1 then
                self.DPADCoverTop:Activate()
            else
                self.DPADCoverTop:Deactivate()
            end
        end
    end )

    self.DPADCoverTop:subscribeToGlobalModel( controller, "PerController", "bgb_activations_remaining", function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue > 0 then
                self.DPADCoverTop.DPADBacking:setAlpha( 1.0 )
                self.DPADCoverTop.SlotText:setAlpha( 1.0 )
                self.DPADCoverTop.SlotText:setText( ModelValue )
            else
                self.DPADCoverTop.DPADBacking:setAlpha( 0.0 )
                self.DPADCoverTop.SlotText:setAlpha( 0.0 )
            end
        end
    end )


    local DPADCoverRight = CoD.T5AmmoDPADCoverWidget.new( menu, controller )
    DPADCoverRight:setLeftRight( true, true, -49 - 30, 49 - 30 )
    DPADCoverRight:setTopBottom( true, true, 0, 0 )
    DPADCoverRight:setElementRotation( 90 )
    DPADCoverRight:setElementBind( "[{+actionslot 4}]" )

    self:addElement( DPADCoverRight )
    self.DPADCoverRight = DPADCoverRight

    self.DPADCoverRight:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue > 0 then
                self.DPADCoverRight:Activate()

                self.DPADCoverRight.DPADBacking:setAlpha( 1.0 )
                self.DPADCoverRight.SlotText:setAlpha( 1.0 )
                self.DPADCoverRight.SlotText:setText( ModelValue )
            else
                self.DPADCoverRight:Deactivate()

                self.DPADCoverRight.DPADBacking:setAlpha( 0.0 )
                self.DPADCoverRight.SlotText:setAlpha( 0.0 )
            end
        end
    end )


    local DPADCoverBottom = CoD.T5AmmoDPADCoverWidget.new( menu, controller )
    DPADCoverBottom:setLeftRight( true, true, -4, 4 )
    DPADCoverBottom:setTopBottom( true, true, -49 - 30, 49 - 30 )
    DPADCoverBottom:setElementRotation( 180 )
    DPADCoverBottom:setElementBind( "[{+actionslot 2}]" )

    self:addElement( DPADCoverBottom )
    self.DPADCoverBottom = DPADCoverBottom

    self.DPADCoverBottom:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue == 1 then
                self.DPADCoverBottom:Activate()
            else
                self.DPADCoverBottom:Deactivate()
            end
        end
    end )

    local DPADCoverLeft = CoD.T5AmmoDPADCoverWidget.new( menu, controller )
    DPADCoverLeft:setLeftRight( true, true, 49, -49 )
    DPADCoverLeft:setTopBottom( true, true, 2, 2 )
    DPADCoverLeft:setElementRotation( 270 )
    DPADCoverLeft:setElementBind( "[{+actionslot 3}]" )

    self:addElement( DPADCoverLeft )
    self.DPADCoverLeft = DPADCoverLeft

    self.DPADCoverLeft:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadLeft" ), function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue == 1 then
                self.DPADCoverLeft:Activate()
            else
                self.DPADCoverLeft:Deactivate()
            end
        end
    end )

    self.DPADCoverLeft:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot4ammo" ), function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            self.DPADCoverLeft.SlotText:setText( ModelValue )
        end
    end )

    self.DPADCoverLeft:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadLeftWeapon" ), function ( modelRef )
        local ModelValue = Engine.GetModelValue( modelRef )
        if ModelValue then
            if ModelValue == CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_40MM then
                self.DPADCoverLeft.DPADImage:setImage( RegisterImage( "hud_40mmgrenade" ) )
            elseif ModelValue == CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_MASTERKEY then
                self.DPADCoverLeft.DPADImage:setImage( RegisterImage( "hud_mk_generic" ) )
            elseif ModelValue == CoD.T5AmmoDPADWidget.DPAD_WEAP_TYPE_FLAMETHROWER then
                self.DPADCoverLeft.DPADImage:setImage( RegisterImage( "hud_flamethrower" ) )
            end
        else
            self.DPADCoverLeft.DPADImage:setImage( RegisterImage( "blacktransparent" ) )
        end
    end )

    -- images--------------------------------------------------------------------------------------------------------------
    local FactionBackLight = LUI.UIImage.new()
    FactionBackLight:setLeftRight( false, true, -132, 6 )
    FactionBackLight:setTopBottom( false, true, -133.5, 4.5 )
    FactionBackLight:setAlpha( 0.4 )
    FactionBackLight:setRGB( 1.0, 1.0, 1.0 )
    FactionBackLight:setImage( RegisterImage( "hud_faction_back_light" ) )

    self.DPADParent:addElement( FactionBackLight )
    self.FactionBackLight = FactionBackLight


    local OuterFrame = LUI.UIImage.new()
    OuterFrame:setLeftRight( false, true, -132, 6 )
    OuterFrame:setTopBottom( false, true, -133.5, 4.5 )
    OuterFrame:setAlpha( 0.5 )
    OuterFrame:setRGB( 1.0, 1.0, 1.0 )
    OuterFrame:setImage( RegisterImage( "hud_dpad_outer_frame" ) )

    self.DPADParent:addElement( OuterFrame )
    self.OuterFrame = OuterFrame


    local OuterFrameRim = LUI.UIImage.new()
    OuterFrameRim:setLeftRight( false, true, -132, 6 )
    OuterFrameRim:setTopBottom( false, true, -133.5, 4.5 )
    OuterFrameRim:setAlpha( 0.4 )
    OuterFrameRim:setRGB( 1.0, 1.0, 1.0 )
    OuterFrameRim:setImage( RegisterImage( "hud_dpad_outer_frame_rim" ) )

    self.DPADParent:addElement( OuterFrameRim )
    self.OuterFrameRim = OuterFrameRim


    local SlotTextParent = LUI.UIElement.new()
    SlotTextParent:setLeftRight( true, true, 0, 0 )
    SlotTextParent:setTopBottom( true, true, 0, 0 )

    self:addElement( SlotTextParent )
    self.SlotTextParent = SlotTextParent


    local DPAD = LUI.UIImage.new()
    DPAD:setLeftRight( false, true, -97.5, -30 )
    DPAD:setTopBottom( false, true, -99, -31.5 )
    DPAD:setAlpha( 1.0 )
    DPAD:setRGB( 1.0, 1.0, 1.0 )
    DPAD:setImage( RegisterImage( "hud_dpad_xenon" ) )

    self.DPADParent:addElement( DPAD )
    self.DPAD = DPAD


    local DPADOverlay = LUI.UIImage.new()
    DPADOverlay:setLeftRight( false, true, -132, 6 )
    DPADOverlay:setTopBottom( false, true, -133.5, 4.5 )
    DPADOverlay:setAlpha( 0.5 )
    DPADOverlay:setRGB( 1.0, 1.0, 1.0 )
    DPADOverlay:setImage( RegisterImage( "hud_dpad_overlay_x" ) )

    self.DPADParent:addElement( DPADOverlay )
    self.DPADOverlay = DPADOverlay


    local DPADOverlayCircle = LUI.UIImage.new()
    DPADOverlayCircle:setLeftRight( false, true, -132, 6 )
    DPADOverlayCircle:setTopBottom( false, true, -133.5, 4.5 )
    DPADOverlayCircle:setAlpha( 0.5 )
    DPADOverlayCircle:setRGB( 1.0, 1.0, 1.0 )
    DPADOverlayCircle:setImage( RegisterImage( "hud_dpad_overlay_circle" ) )

    self.DPADParent:addElement( DPADOverlayCircle )
    self.DPADOverlayCircle = DPADOverlayCircle


    self.DPADParent.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self.DPADParent:setupElementClipCounter( 3 )
                
                self.DPAD:completeAnimation()
                self.DPAD:setAlpha( 1.0 )
                self.DPADParent.clipFinished( self.DPAD, {} )

                self.DPADOverlay:completeAnimation()
                self.DPADOverlay:setAlpha( 0.5 )
                self.DPADParent.clipFinished( self.DPADOverlay, {} )

                self.DPADOverlayCircle:completeAnimation()
                self.DPADOverlayCircle:setAlpha( 0.5 )
                self.DPADParent.clipFinished( self.DPADOverlayCircle, {} )
            end
        },
        Hidden = {
            DefaultClip = function()
                self.DPADParent:setupElementClipCounter( 3 )
                
                self.DPAD:completeAnimation()
                self.DPAD:setAlpha( 0.0 )
                self.DPADParent.clipFinished( self.DPAD, {} )

                self.DPADOverlay:completeAnimation()
                self.DPADOverlay:setAlpha( 0.0 )
                self.DPADParent.clipFinished( self.DPADOverlay, {} )

                self.DPADOverlayCircle:completeAnimation()
                self.DPADOverlayCircle:setAlpha( 0.0 )
                self.DPADParent.clipFinished( self.DPADOverlayCircle, {} )
            end
        }
    }

    self.DPADParent.StateTable = {
        {
            stateName = "Hidden",
            condition = function( menu, element, event )
                return not ( Engine.IsControllerUsed( controller ) )
            end
        }
    }

    self.DPADParent:mergeStateConditions( self.DPADParent.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, self.DPADParent, "LastInput" )

	return self
end