-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5AmmoDPADCoverWidget = InheritFrom( LUI.UIElement )

CoD.T5AmmoDPADCoverWidget.SlotsActive = { r = 1.0, g = 1.0, b = 0.5 }
CoD.T5AmmoDPADCoverWidget.SlotsInactive = { r = 0.3, g = 0.3, b = 0.3 }

function CoD.T5AmmoDPADCoverWidget.new( menu, controller )
	local self = LUI.UIElement.new()
	self:setClass( CoD.T5AmmoDPADCoverWidget )
    self.id = "T5AmmoDPADCoverWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true

    -- LR -138 		6
    -- TB -121.5 	22.5
    local OuterFrameHighlight = LUI.UIImage.new()
    OuterFrameHighlight:setLeftRight( false, true, -138, 6 )
    OuterFrameHighlight:setTopBottom( false, true, -121.5, 22.5 )
    OuterFrameHighlight:setAlpha( 1.0 )
    OuterFrameHighlight:setScale( 1.0 )
    OuterFrameHighlight:setRGB( 1.0, 1.0, 1.0 )
    OuterFrameHighlight:setImage( RegisterImage( "hud_dpad_outer_frame_highlight_up" ) )

    self:addElement( OuterFrameHighlight )
    self.OuterFrameHighlight = OuterFrameHighlight


    local CoverParent = LUI.UIElement.new()
    CoverParent:setLeftRight( false, true, -80, -48 )
    CoverParent:setTopBottom( false, true, -65.5, -33.5 )

    self:addElement( CoverParent )
    self.CoverParent = CoverParent


    local BindParent = LUI.UIElement.new()
    BindParent:setLeftRight( false, true, -80, -48 )
    BindParent:setTopBottom( false, true, -65.5, -33.5 )

    self:addElement( BindParent )
    self.BindParent = BindParent


    local DPADImage = LUI.UIImage.new()
    DPADImage:setLeftRight( true, true, 0, 0 )
    DPADImage:setTopBottom( true, true, -10, -10 )
    DPADImage:setAlpha( 1.0 )
    DPADImage:setScale( 1.2 )
    DPADImage:setRGB( 1.0, 1.0, 1.0 )
    DPADImage:setImage( RegisterImage( "hud_claymore" ) )

    self.CoverParent:addElement( DPADImage )
    self.DPADImage = DPADImage


    local DPADImageCustom = LUI.UIImage.new()
    DPADImageCustom:setLeftRight( true, true, 0, 0 )
    DPADImageCustom:setTopBottom( true, true, -10, -10 )
    DPADImageCustom:setAlpha( 0.0 )
    DPADImageCustom:setScale( 1.2 )
    DPADImageCustom:setRGB( 1.0, 1.0, 1.0 )
    DPADImageCustom:setImage( RegisterImage( "hud_claymore" ) )
    DPADImageCustom:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta_normal" ) )
    DPADImageCustom:setShaderVector( 0, 0, 1, 0, 0 )
    DPADImageCustom:setShaderVector( 1, 0, 0, 0, 0 )
    DPADImageCustom:setShaderVector( 3, 0.02, 0, 0, 0 )

    self.CoverParent:addElement( DPADImageCustom )
    self.DPADImageCustom = DPADImageCustom


    local DPADBacking = LUI.UIImage.new()
    DPADBacking:setLeftRight( true, true, 0, 0 )
    DPADBacking:setTopBottom( true, true, -10, -10 )
    DPADBacking:setAlpha( 0.9 )
    DPADBacking:setScale( 0.4 )
    DPADBacking:setRGB( 0.0, 0.0, 0.0 )
    DPADBacking:setImage( RegisterImage( "hud_dpad_eqip_count_backing" ) )

    self.CoverParent:addElement( DPADBacking )
    self.DPADBacking = DPADBacking


    local SlotText = CoD.UIShadowText.new( menu, controller )
    SlotText:setLeftRight( true, true, -10, 10 )
    SlotText:setTopBottom( true, true, -8, -10 )
    SlotText:setAlpha( 1.0 )
    SlotText:setScale( 0.6 )
    SlotText:setTTF( "fonts/helveticaneue.ttf" )
    SlotText:setText( "2" )
    SlotText:setRGB( 1.0, 1.0, 1.0 )

    self.CoverParent:addElement( SlotText )
    self.SlotText = SlotText


    local SlotBind = CoD.UIShadowText.new( menu, controller )
    SlotBind:setLeftRight( true, true, -6, 6 )
    SlotBind:setTopBottom( true, true, 10, 27.5 )
    SlotBind:setAlpha( 1.0 )
    SlotBind:setScale( 0.2750 )
    SlotBind:setTTF( "fonts/helveticaneue.ttf" )
    SlotBind:setText( "[" .. "[{+actionslot 1}]" .. "]" )
    SlotBind:setRGB( CoD.T5AmmoDPADCoverWidget.SlotsInactive.r, CoD.T5AmmoDPADCoverWidget.SlotsInactive.g, CoD.T5AmmoDPADCoverWidget.SlotsInactive.b )
    SlotBind:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )

    SlotBind.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                SlotBind:setupElementClipCounter( 2 )
                
                SlotBind.Text:completeAnimation()
                SlotBind.Text:setAlpha( 1.0 )
                SlotBind.clipFinished( SlotBind.Text, {} )

                SlotBind.TextShadow:completeAnimation()
                SlotBind.TextShadow:setAlpha( 1.0 )
                SlotBind.clipFinished( SlotBind.TextShadow, {} )
            end
        },
        Hidden = {
            DefaultClip = function()
                SlotBind:setupElementClipCounter( 2 )
                
                SlotBind.Text:completeAnimation()
                SlotBind.Text:setAlpha( 0.0 )
                SlotBind.clipFinished( SlotBind.Text, {} )

                SlotBind.TextShadow:completeAnimation()
                SlotBind.TextShadow:setAlpha( 0.0 )
                SlotBind.clipFinished( SlotBind.TextShadow, {} )
            end
        }
    }

    SlotBind.StateTable = {
        {
            stateName = "Hidden",
            condition = function( menu, element, event )
                return Engine.IsControllerUsed( controller )
            end
        }
    }

    SlotBind:mergeStateConditions( SlotBind.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, SlotBind, "LastInput" )

    self.BindParent:addElement( SlotBind )
    self.SlotBind = SlotBind


    -- hardcode the values because im lazy
    self.setElementRotation = function( self, degrees )
        --right
    	if degrees == 90 then
    		self.OuterFrameHighlight:setImage( RegisterImage( "hud_dpad_outer_frame_highlight_side" ) )
    		self.OuterFrameHighlight:setLeftRight( false, true, -121.5, 22.5 )
    		self.OuterFrameHighlight:setTopBottom( false, true, -138, 6 )
            self.OuterFrameHighlight:setZRot( 180 )
            self.CoverParent:setLeftRight( false, true, -80 + 27, -48 + 27 )
            self.CoverParent:setTopBottom( false, true, -65.5, -33.5 )
            self.BindParent:setLeftRight( false, true, -80 + 27, -48 + 27 )
            self.BindParent:setTopBottom( false, true, -65.5, -33.5 )
            self.SlotBind:setLeftRight( true, true, -6 - 27, 6 - 27 )
            self.SlotBind:setTopBottom( true, true, 10 - 27.5 - 6, 27.5 - 27.5 - 6 )
        --bottom
        elseif degrees == 180 then
            self.OuterFrameHighlight:setImage( RegisterImage( "hud_dpad_outer_frame_highlight_up" ) )
            self.OuterFrameHighlight:setLeftRight( false, true, -138, 6 )
            self.OuterFrameHighlight:setTopBottom( false, true, -121.5, 22.5 )
            self.OuterFrameHighlight:setZRot( 180 )
            self.CoverParent:setLeftRight( false, true, -80 - 4, -48 - 4 )
            self.CoverParent:setTopBottom( false, true, -65.5 + 15, -33.5 + 15 )
            self.BindParent:setLeftRight( false, true, -80 - 4, -48 - 4 )
            self.BindParent:setTopBottom( false, true, -65.5 + 15, -33.5 + 15 )
            self.SlotBind:setLeftRight( true, true, -6, 6 )
            self.SlotBind:setTopBottom( true, true, 10 - 50, 27.5 - 50 )
        --left
    	elseif degrees == 270 then
    		self.OuterFrameHighlight:setImage( RegisterImage( "hud_dpad_outer_frame_highlight_side" ) )
    		self.OuterFrameHighlight:setLeftRight( false, true, -121.5, 22.5 )
    		self.OuterFrameHighlight:setTopBottom( false, true, -138, 6 )
            self.CoverParent:setLeftRight( false, true, -80 + 5, -48 + 5 )
            self.CoverParent:setTopBottom( false, true, -65.5 - 4, -33.5 - 4 )
            self.BindParent:setLeftRight( false, true, -80 + 5, -48 + 5 )
            self.BindParent:setTopBottom( false, true, -65.5 - 4, -33.5 - 4 )
            self.SlotBind:setLeftRight( true, true, -6 + 27, 6 + 27 )
            self.SlotBind:setTopBottom( true, true, 10 - 27.5 - 4, 27.5 - 27.5 - 4 )
        -- top
    	else
    		self.OuterFrameHighlight:setImage( RegisterImage( "hud_dpad_outer_frame_highlight_up" ) )
    		self.OuterFrameHighlight:setLeftRight( false, true, -138, 6 )
    		self.OuterFrameHighlight:setTopBottom( false, true, -121.5, 22.5 )
            self.CoverParent:setLeftRight( false, true, -80, -48 )
            self.CoverParent:setTopBottom( false, true, -65.5, -33.5 )
            self.BindParent:setLeftRight( false, true, -80, -48 )
            self.BindParent:setTopBottom( false, true, -65.5, -33.5 )
            self.SlotBind:setLeftRight( true, true, -6, 6 )
            self.SlotBind:setTopBottom( true, true, 10, 27.5 )
    	end
	end

    self.setElementBind = function( self, bind )
        self.SlotBind:setText( "[" .. bind .. "]" )
    end

    self.Activate = function( self )
        self.SlotBind:setRGB( CoD.T5AmmoDPADCoverWidget.SlotsActive.r, CoD.T5AmmoDPADCoverWidget.SlotsActive.g, CoD.T5AmmoDPADCoverWidget.SlotsActive.b )
        self.CoverParent:setAlpha( 1.0 )
        self.OuterFrameHighlight:setAlpha( 1.0 )
    end

    self.Deactivate = function( self )
        self.SlotBind:setRGB( CoD.T5AmmoDPADCoverWidget.SlotsInactive.r, CoD.T5AmmoDPADCoverWidget.SlotsInactive.g, CoD.T5AmmoDPADCoverWidget.SlotsInactive.b )
        self.CoverParent:setAlpha( 0.0 )
        self.OuterFrameHighlight:setAlpha( 0.0 )
    end

    return self
end