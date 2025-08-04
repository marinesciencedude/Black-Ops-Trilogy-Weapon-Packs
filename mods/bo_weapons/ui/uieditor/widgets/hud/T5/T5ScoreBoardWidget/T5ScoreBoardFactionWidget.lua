-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

require("ui.uieditor.widgets.HUD.T5.T5ScoreBoardWidget.T5ScoreBoardListWidget")

DataSources.ZMScoreBoardList = {
    getModel = function(controller)
        return Engine.GetModel(Engine.GetGlobalModel(), "scoreboard.team1")
    end
}

CoD.T5ScoreBoardFactionWidget = InheritFrom( LUI.UIElement )

function CoD.T5ScoreBoardFactionWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end
    
    self:setClass( CoD.T5ScoreBoardFactionWidget )
    self.id = "T5ScoreBoardFactionWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true
    self:setLeftRight( true, false, 0.0, 829.0 )
    self:setTopBottom( true, false, 0.0, 468.0 )

    local ScoreBoardDummy = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
    ScoreBoardDummy:setWidgetType(CoD.T5ScoreBoardListWidget)
    ScoreBoardDummy:setDataSource("ScoreboardTeam1List")
    ScoreBoardDummy:setAlpha(0)

    self:addElement(ScoreBoardDummy)
    self.ScoreBoardDummy = ScoreBoardDummy


    local ScoreList1 = CoD.T5ScoreBoardListWidget.new(menu, controller)
    ScoreList1:setLeftRight( true, false, 0.0, 853.0 )
    ScoreList1:setTopBottom( true, false, 0.0, 25.0 )

    ScoreList1:subscribeToGlobalModel(controller, "ZMScoreBoardList", "0", function(ModelRef)
        ScoreList1:setModel(ModelRef, controller)
    end)

    self:addElement(ScoreList1)
    self.ScoreList1 = ScoreList1


    local ScoreList2 = CoD.T5ScoreBoardListWidget.new(menu, controller)
    ScoreList2:setLeftRight( true, false, 0.0, 853.0 )
    ScoreList2:setTopBottom( true, false, 25.0, 50.0 )

    ScoreList2:subscribeToGlobalModel(controller, "ZMScoreBoardList", "1", function(ModelRef)
        ScoreList2:setModel(ModelRef, controller)
    end)

    self:addElement(ScoreList2)
    self.ScoreList2 = ScoreList2


    local ScoreList3 = CoD.T5ScoreBoardListWidget.new(menu, controller)
    ScoreList3:setLeftRight( true, false, 0.0, 853.0 )
    ScoreList3:setTopBottom( true, false, 50.0, 75.0 )

    ScoreList3:subscribeToGlobalModel(controller, "ZMScoreBoardList", "2", function(ModelRef)
        ScoreList3:setModel(ModelRef, controller)
    end)

    self:addElement(ScoreList3)
    self.ScoreList3 = ScoreList3


    local ScoreList4 = CoD.T5ScoreBoardListWidget.new(menu, controller)
    ScoreList4:setLeftRight( true, false, 0.0, 853.0 )
    ScoreList4:setTopBottom( true, false, 75.0, 100.0 )

    ScoreList4:subscribeToGlobalModel(controller, "ZMScoreBoardList", "3", function(ModelRef)
        ScoreList4:setModel(ModelRef, controller)
    end)

    self:addElement(ScoreList4)
    self.ScoreList4 = ScoreList4

    return self
end