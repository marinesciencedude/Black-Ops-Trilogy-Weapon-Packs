-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5ScoreBoardListWidget = InheritFrom(LUI.UIElement)
CoD.T5ScoreBoardListWidget.ColumnStartNumber = 335.41
CoD.T5ScoreBoardListWidget.ColumnWidth = 87

local PreLoadFunc = function ( self, controller )
    local model = Engine.GetModelForController( controller )
    self:subscribeToModel( Engine.CreateModel( Engine.GetGlobalModel(), "fastRestart" ), function ( modelRef )
        self:setAlpha( 0 )
    end, false )
    self:setAlpha( 0 )
end

function CoD.T5ScoreBoardListWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:makeFocusable()
    self:setUseStencil(false)
    self:setClass( CoD.T5ScoreBoardListWidget )
    self.id = "T5ScoreBoardListWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 868 )
    self:setTopBottom( true, false, 0, 25 )

    local ScoreBar = LUI.UIImage.new()
    ScoreBar:setLeftRight( true, true, 0, -60 )
    ScoreBar:setTopBottom( true, true, 0, 0 )
    ScoreBar:setImage( RegisterImage( "blacktransparent" ) )
    ScoreBar:setRGB( 0.48, 0, 0 )
    ScoreBar:setAlpha( 1 )

    self:addElement(ScoreBar)
    self.ScoreBar = ScoreBar

    local RankIcon = LUI.UIImage.new()
    RankIcon:setLeftRight(true, false, 52, 76)
    RankIcon:setTopBottom(false, false, -12, 12)
    RankIcon:setImage( RegisterImage( "blacktransparent" ) )

    self:addElement(RankIcon)
    self.RankIcon = RankIcon

    local Gamertag = CoD.UIShadowText.new( menu, controller )
    Gamertag:setLeftRight(true, false, 0, CoD.T5ScoreBoardListWidget.ColumnStartNumber)
    Gamertag:setTopBottom(false, false, -12, 10)
    Gamertag:setTTF("fonts/helveticaneue.ttf")
    Gamertag:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
    Gamertag:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)

    self:addElement(Gamertag)
    self.Gamertag = Gamertag


    local ScoreColumn1 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn1:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 0 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 1 ) )
    ScoreColumn1:setTopBottom(false, false, -12, 10)
    ScoreColumn1:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn1:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    ScoreColumn1:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreColumn1:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 0, ModelValue ) ) )
        end
    end )

    self:addElement(ScoreColumn1)
    self.ScoreColumn1 = ScoreColumn1


    local ScoreColumn2 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn2:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 1 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 2 ) )
    ScoreColumn2:setTopBottom(false, false, -12, 10)
    ScoreColumn2:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn2:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    ScoreColumn2:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreColumn2:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 1, ModelValue ) ) )
        end
    end )

    self:addElement(ScoreColumn2)
    self.ScoreColumn2 = ScoreColumn2


    local ScoreColumn3 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn3:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 2 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 3 ) )
    ScoreColumn3:setTopBottom(false, false, -12, 10)
    ScoreColumn3:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn3:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    ScoreColumn3:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreColumn3:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 2, ModelValue ) ) )
        end
    end )

    self:addElement(ScoreColumn3)
    self.ScoreColumn3 = ScoreColumn3


    local ScoreColumn4 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn4:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 3 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 4 ) )
    ScoreColumn4:setTopBottom(false, false, -12, 10)
    ScoreColumn4:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn4:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    ScoreColumn4:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreColumn4:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 3, ModelValue ) ) )
        end
    end )

    self:addElement(ScoreColumn4)
    self.ScoreColumn4 = ScoreColumn4


    local ScoreColumn5 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn5:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 4 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 5 ))
    ScoreColumn5:setTopBottom(false, false, -12, 10)
    ScoreColumn5:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn5:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)

    ScoreColumn5:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreColumn5:setText( Engine.Localize( GetScoreboardPlayerScoreColumn( controller, 4, ModelValue ) ) )
        end
    end )

    self:addElement(ScoreColumn5)
    self.ScoreColumn5 = ScoreColumn5


    local pvBackground = LUI.UIImage.new()
    pvBackground:setLeftRight(false, true, -60, -24)
    pvBackground:setTopBottom(true, true, 0, 0)
    pvBackground:setRGB(0.35, 0.3, 0.3)
    pvBackground:setAlpha(GetScoreboardPingValueAlpha(0.5))

    self:addElement(pvBackground)
    self.pvBackground = pvBackground

    
    local PingText = CoD.UIShadowText.new( menu, controller )
    PingText:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 5 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 6 ))
    PingText:setTopBottom(false, false, -12, 10)
    PingText:setAlpha( GetScoreboardPingValueAlpha( 1 ) )
    PingText:setTTF( "fonts/helveticaneue.ttf")
    PingText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    PingText:linkToElementModel( self, "ping", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            PingText:setText( ModelValue )
        end
    end )

    self:addElement(PingText)
    self.PingText = PingText

    
    local VOIPImage = LUI.UIImage.new()
    VOIPImage:setLeftRight(true, false, 342 - 30, 363 - 30)
    VOIPImage:setTopBottom(true, false, 2.5, 23.5)
    VOIPImage:setAlpha(0)
    VOIPImage:linkToElementModel( self, "clientNum", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            VOIPImage:setupVoipImage( ModelValue )
        end
    end )

    self:addElement(VOIPImage)
    self.VOIPImage = VOIPImage

    
    local ScoreboardRowDeathIcon = LUI.UIImage.new()
    ScoreboardRowDeathIcon:setLeftRight(true, false, 0, 23)
    ScoreboardRowDeathIcon:setTopBottom(true, false, 1, 24)
    ScoreboardRowDeathIcon:linkToElementModel( self, "clientNum", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            ScoreboardRowDeathIcon:setupClientStatusImage( ModelValue )
        end
    end )

    self:addElement(ScoreboardRowDeathIcon)
    self.ScoreboardRowDeathIcon = ScoreboardRowDeathIcon


    self:linkToElementModel( self, "clientNum", true, function ( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            local clientName = GetClientNameAndClanTag( controller, ModelValue )
            if clientName ~= "" then
                self:setAlpha( 1.0 )

                self:setLeftRight( true, false, 0.0, 852.82 )
                self:setTopBottom( true, false, 0.0 + ( ModelValue * 25.0 ), 25.0 + ( ModelValue * 25.0 ) )

                Gamertag:setText( clientName )
                Gamertag:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                ScoreColumn1:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                ScoreColumn2:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                ScoreColumn3:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                ScoreColumn4:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                ScoreColumn5:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )
                PingText:setRGB( CoD.T5ScoreBoardListWidget.GetScoreBarColor( ModelValue ) )

                ScoreBar:setImage( RegisterImage( "scorebar_zom_long_" .. tostring( ( ModelValue % 4 ) + 1 ) ) )
                RankIcon:setImage( RegisterImage( GetScoreboardPlayerRankIcon( controller, ModelValue ) ) )
            end
        else
            self:setAlpha( 0.0 )
        end
    end )

    self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( ModelRef )
        menu:updateElementState(self, {name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( ModelRef ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED})
    end )
    self:linkToElementModel( self, "clientNum", true, function ( ModelRef )
        menu:updateElementState(self, {name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( ModelRef ), modelName = "clientNum"})
    end )
    self:linkToElementModel( self, "clientNumScoreInfoUpdated", true, function ( ModelRef )
        menu:updateElementState(self, {name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( ModelRef ), modelName = "clientNumScoreInfoUpdated"})
    end )

    return self
end

CoD.T5ScoreBoardListWidget.GetScoreBarColor = function ( index )
    if CoD.isZombie == true then
        local playerColorIndex = ( index ) % 4 + 1
        return CoD.Zombie.PlayerColors[playerColorIndex].r, CoD.Zombie.PlayerColors[playerColorIndex].g, CoD.Zombie.PlayerColors[playerColorIndex].b
    else
        return CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b
    end
end