-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

require("ui.uieditor.widgets.HUD.T5.T5ScoreBoardWidget.T5ScoreBoardFactionWidget")
require("ui.uieditor.widgets.HUD.T5.T5ScoreBoardWidget.T5ScoreBoardHeaderWidget")

require("ui.uieditor.widgets.Scoreboard.ScoreboardWidgetButtonContainer")

CoD.T5ScoreBoardWidget = InheritFrom( LUI.UIElement )

function CoD.T5ScoreBoardWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.T5ScoreBoardWidget )
    self.id = "T5ScoreBoardWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true

    local ScoresList = CoD.T5ScoreBoardFactionWidget.new(menu, controller)
    ScoresList:setLeftRight(true, true, 0, 0)
    ScoresList:setTopBottom(true, true, 30, 0)
    --ScoresList.Team1:setVerticalCount(4)
    ScoresList:registerEventHandler("list_item_gain_focus", CoD.T5ScoreBoardWidget.ItemFocus)
    ScoresList:registerEventHandler("gain_focus", CoD.T5ScoreBoardWidget.Focus)
    ScoresList:registerEventHandler("lose_focus", CoD.T5ScoreBoardWidget.UnFocus)
    menu:AddButtonCallbackFunction(ScoresList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, nil, CoD.T5ScoreBoardWidget.ButtonFunction, CoD.T5ScoreBoardWidget.ButtonSetLabel, false)
    self:addElement(ScoresList)
    self.ScoreboardFactionScoresListCP0 = ScoresList

    local ScoreboardWidgetButtonContainer = CoD.ScoreboardWidgetButtonContainer.new(menu, controller)
    ScoreboardWidgetButtonContainer:setLeftRight(true, false, -15, 430)
    ScoreboardWidgetButtonContainer:setTopBottom(true, false, 504, 536)

    self:addElement(ScoreboardWidgetButtonContainer)
    self.ScoreboardWidgetButtonContainer = ScoreboardWidgetButtonContainer


    local ScoreboardHeaderWidget = CoD.T5ScoreBoardHeaderWidget.new(menu, controller)
    ScoreboardHeaderWidget:setLeftRight(true, false, 0, 996)
    ScoreboardHeaderWidget:setTopBottom(true, false, 0, 32)

    self:addElement(ScoreboardHeaderWidget)
    self.ScoreboardHeaderWidget = ScoreboardHeaderWidget

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(1)
                self:beginAnimation("keyframe", 25, false, false, CoD.TweenType.Linear)
                self:setAlpha(1)
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter(1)
                self:beginAnimation("keyframe", 25, false, false, CoD.TweenType.Linear)
                self:setAlpha(0)
            end
        }
    }
    
    self.StateTable = {
        {
            stateName = "Hidden",
            condition = function(menu, controller, event)
                return not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
            end
        }
    }

    self:mergeStateConditions(self.StateTable)
    
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)

    return self
end

CoD.T5ScoreBoardWidget.ItemFocus = function (Sender, Event)
    UpdateScoreboardClientMuteButtonPrompt(Sender, controller)
    return nil
end

CoD.T5ScoreBoardWidget.Focus = function (Sender, Event)
    local f14_local0 = nil
    if Sender.gainFocus then
        f14_local0 = Sender:gainFocus(Event)
    elseif Sender.super.gainFocus then
        f14_local0 = Sender:gainFocus(Event)
    end
    CoD.Menu.UpdateButtonShownState(Sender, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
    return f14_local0
end

CoD.T5ScoreBoardWidget.UnFocus = function (Sender, Event)
    local f15_local0 = nil
    if Sender.loseFocus then
        f15_local0 = Sender:loseFocus(Event)
    elseif Sender.super.loseFocus then
        f15_local0 = Sender:loseFocus(Event)
    end
    return f15_local0
end

CoD.T5ScoreBoardWidget.ButtonFunction = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3)
    if ScoreboardVisible(f16_arg2) then
        BlockGameFromKeyEvent(f16_arg2)
        return true
    else

    end
end

CoD.T5ScoreBoardWidget.ButtonSetLabel = function (f17_arg0, f17_arg1, f17_arg2)
    if ScoreboardVisible(f17_arg2) then
        CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "")
            return false
    else
        return false
    end
end