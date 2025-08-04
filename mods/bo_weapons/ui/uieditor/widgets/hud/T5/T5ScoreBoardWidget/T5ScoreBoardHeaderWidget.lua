-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5ScoreBoardHeaderWidget = InheritFrom(LUI.UIElement)
CoD.T5ScoreBoardHeaderWidget.ColumnStartNumber = 335.41
CoD.T5ScoreBoardHeaderWidget.ColumnWidth = 87

function CoD.T5ScoreBoardHeaderWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setUseStencil(false)
    self:setClass( CoD.T5ScoreBoardHeaderWidget )
    self.id = "T5ScoreBoardHeaderWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0, 868 )
    self:setTopBottom( true, false, 0, 32 )

    local ScoreColumn1 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn1:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 0 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 1 ) )
    ScoreColumn1:setTopBottom(false, false, -12, 10)
    ScoreColumn1:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn1:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    ScoreColumn1:setText(Engine.Localize(GetScoreboardColumnName(controller, 0, "Score")))

    self:addElement(ScoreColumn1)
    self.ScoreColumn1 = ScoreColumn1


    local ScoreColumn2 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn2:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 1 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 2 ) )
    ScoreColumn2:setTopBottom(false, false, -12, 10)
    ScoreColumn2:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn2:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    ScoreColumn2:setText(Engine.Localize(GetScoreboardColumnName(controller, 1, "Score")))

    self:addElement(ScoreColumn2)
    self.ScoreColumn2 = ScoreColumn2


    local ScoreColumn3 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn3:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 2 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 3 ) )
    ScoreColumn3:setTopBottom(false, false, -12, 10)
    ScoreColumn3:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn3:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    ScoreColumn3:setText(Engine.Localize(GetScoreboardColumnName(controller, 2, "Score")))

    self:addElement(ScoreColumn3)
    self.ScoreColumn3 = ScoreColumn3


    local ScoreColumn4 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn4:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 3 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 4 ) )
    ScoreColumn4:setTopBottom(false, false, -12, 10)
    ScoreColumn4:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn4:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    ScoreColumn4:setText(Engine.Localize(GetScoreboardColumnName(controller, 3, "Score")))

    self:addElement(ScoreColumn4)
    self.ScoreColumn4 = ScoreColumn4


    local ScoreColumn5 = CoD.UIShadowText.new( menu, controller )
    ScoreColumn5:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 4 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 5 ))
    ScoreColumn5:setTopBottom(false, false, -12, 10)
    ScoreColumn5:setTTF("fonts/helveticaneue.ttf")
    ScoreColumn5:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    ScoreColumn5:setText(Engine.Localize(GetScoreboardColumnName(controller, 4, "Score")))

    self:addElement(ScoreColumn5)
    self.ScoreColumn5 = ScoreColumn5

    local PingColumn = CoD.UIShadowText.new( menu, controller )
    PingColumn:setLeftRight(true, false, ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 5 ), ( ( CoD.T5ScoreBoardListWidget.ColumnStartNumber ) + CoD.T5ScoreBoardListWidget.ColumnWidth * 6 ))
    PingColumn:setTopBottom(false, false, -12, 10)
    PingColumn:setTTF("fonts/helveticaneue.ttf")
    PingColumn:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
    PingColumn:setText( Engine.Localize( "CGAME_SB_PING" ) )
    PingColumn:setAlpha( GetScoreboardPingValueAlpha( 1 ) )

    self:addElement(PingColumn)
    self.PingColumn = PingColumn

    return self
end