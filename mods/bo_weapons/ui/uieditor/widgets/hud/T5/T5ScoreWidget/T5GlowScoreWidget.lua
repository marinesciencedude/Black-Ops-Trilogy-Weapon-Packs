require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5GlowScoreWidget = InheritFrom( LUI.UIElement )

function CoD.T5GlowScoreWidget.new( menu, controller, scoreDiff, isPositive, scale )
    local self = LUI.UIElement.new()
    self:setClass(CoD.T5GlowScoreWidget)
    self.id = "T5GlowScoreWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self:setLeftRight( true, false, -30, ( -30 + 150 ) )
    self:setTopBottom( true, false, 0, 30 )
    self:setScale(scale)

    if CoD.T5ScoreWidget.UseT7GlowStyle() then
        local GlowText2 = LUI.UIText.new()
        GlowText2:setText( Engine.Localize( "-" .. scoreDiff ) )
        GlowText2:setTTF( "fonts/helveticaneue.ttf" )
        GlowText2:setRGB( 0.59, 0.15, 0.11 )
        GlowText2:setLeftRight( true, false, -1, 149 )
        GlowText2:setTopBottom( true, false, -1, 29 )
        GlowText2:setAlpha( 0.43 )
        GlowText2:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
        GlowText2:setShaderVector( 0, 0.21, 0, 0, 0 )
        GlowText2:setShaderVector( 1, 0, 0, 0, 0 )
        GlowText2:setShaderVector( 2, 1, 0, 0, 0 )
        GlowText2:setLetterSpacing( 0.9 )
        GlowText2:setZoom( -8 )

        self:addElement(GlowText2)
        self.GlowText2 = GlowText2
    end

    local GlowText = CoD.UIShadowText.new( menu, controller )
    GlowText:setText( Engine.Localize( "-" .. scoreDiff ) )
    GlowText:setTTF( "fonts/helveticaneue.ttf" )
    if CoD.T5ScoreWidget.UseT7GlowStyle() then
        GlowText:setRGB( 0.78, 0.14, 0.08 )
    else
        GlowText:setRGB( CoD.T5ScoreWidget.NegativeColor.r, CoD.T5ScoreWidget.NegativeColor.g, CoD.T5ScoreWidget.NegativeColor.b )
    end
    GlowText:setLeftRight( true, false, 0, 150 )
    GlowText:setTopBottom( true, false, 0, 30 )

    self:addElement(GlowText)
    self.GlowText = GlowText


    if CoD.T5ScoreWidget.UseT7GlowStyle() then
        local GLowMultiply = LUI.UIImage.new()
        GLowMultiply:setLeftRight( true, false, -30, 45 + ( ( #tostring( scoreDiff ) ) * 15 ) )
        GLowMultiply:setTopBottom( true, false, 0, 30 )
        GLowMultiply:setRGB( 1.0, 0.26, 0 )
        GLowMultiply:setAlpha( 0.26 )
        GLowMultiply:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )

        self:addElement(GLowMultiply)
        self.GLowMultiply = GLowMultiply
    end


    if isPositive then
        if CoD.T5ScoreWidget.UseT7GlowStyle() then
            self.GlowText:setRGB( 0.99, 0.95, 0.62 )
            self.GLowMultiply:setRGB( 1.0, 1.0, 0 )
            self.GlowText2:setRGB( 1, 0.52, 0 )
            self.GlowText2:setText( Engine.Localize( "+" .. scoreDiff ) )
        else
            self.GlowText:setRGB( CoD.T5ScoreWidget.PositiveColor.r, CoD.T5ScoreWidget.PositiveColor.g, CoD.T5ScoreWidget.PositiveColor.b )
        end
        self.GlowText:setText( Engine.Localize( "+" .. scoreDiff ) )
    end

    local leftRightOffset = math.random( 100, 120 )
    local topBottomOffset = math.random( 0, 100 )

    self:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
    self:setLeftRight( true, false, -leftRightOffset, ( -leftRightOffset + 150 ) )
    self:setTopBottom( true, false, ( topBottomOffset - ( ( 0 + 100 ) * 0.5 ) ), ( ( topBottomOffset - ( ( 0 + 100 ) * 0.5 ) ) + 30 ) )
    self:setAlpha( 0.0 )
    self:registerEventHandler( "transition_complete_keyframe", function( element, event )
        element.GlowText:close()
        if CoD.T5ScoreWidget.UseT7GlowStyle() then
            element.GLowMultiply:close()
        end
        element:close()
    end )

    return self
end