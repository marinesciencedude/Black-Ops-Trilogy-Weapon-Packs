-- The Giant HUD, rebuilt by D3V Team and modified by lilrifa

require("ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer")
require("ui.uieditor.widgets.DynamicContainerWidget")
require("ui.uieditor.widgets.HUD.ZM_CursorHint.ZMCursorHint")
require("ui.uieditor.widgets.HUD.CenterConsole.CenterConsole")
require("ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate")
require("ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr")
require("ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown")
require("ui.uieditor.widgets.Scoreboard.CP.ScoreboardWidgetCP")
require("ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer")
require("ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame")

-- T5HUD requires

-- Lilrifa Util Require --
require("UI.LilrifaUtils")
require("UI.SubscriptionUtils")

-- dlc5 requirement
require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconInventoryWidget")
require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconNotificationWidget")

CoD.Zombie.CommonHudRequire()

local function PreLoadCallback(HudRef, InstanceRef)
    CoD.Zombie.CommonPreLoadHud(HudRef, InstanceRef)
end

local function PostLoadCallback(HudRef, InstanceRef)
    CoD.Zombie.CommonPostLoadHud(HudRef, InstanceRef)
end

function LUI.createMenu.T7Hud_zm_factory(InstanceRef)
    local HudRef = CoD.Menu.NewForUIEditor("T7Hud_zm_factory")
    
    if PreLoadCallback then
        PreLoadCallback(HudRef, InstanceRef)
    end
    
    HudRef.soundSet = "HUD"
    HudRef:setOwner(InstanceRef)
    HudRef:setLeftRight(true, true, 0, 0)
    HudRef:setTopBottom(true, true, 0, 0)
    HudRef:playSound("menu_open", InstanceRef)
    
    HudRef.buttonModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "T7Hud_zm_factory.buttonPrompts")
    HudRef.anyChildUsesUpdateState = true

    HudRef:addElement(HUDZMRushPointAward)
    HudRef.HUDZMRushPointAward = HUDZMRushPointAward

    HudRef.fullscreenContainer = CoD.DynamicContainerWidget.new(HudRef, InstanceRef)
    HudRef.fullscreenContainer:setLeftRight(false, false, -640, 640)
    HudRef.fullscreenContainer:setTopBottom(false, false, -360, 360)
    HudRef:addElement(HudRef.fullscreenContainer)
    
    HudRef.CursorHint = CoD.T6HintstringContainer.new(HudRef, InstanceRef)
    HudRef.CursorHint:setLeftRight(false, false, -250.000000, 250.000000)
    HudRef.CursorHint:setTopBottom(true, false, 400.000000, 500.000000)
    HudRef:addElement(HudRef.CursorHint)

    HudRef.CursorHint.StateTable = {
        {
            stateName = "Active_1x1",
            condition = function(HudRef, ItemRef, UpdateTable)
                if IsCursorHintActive(InstanceRef) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
                    return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 1)
                else
                    return false
                end
            end
        },
        {
            stateName = "Active_2x1",
            condition = function(HudRef, ItemRef, UpdateTable)
                if IsCursorHintActive(InstanceRef) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
                    return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 2)
                else
                    return false
                end
            end
        },
        {
            stateName = "Active_4x1",
            condition = function(HudRef, ItemRef, UpdateTable)
                if IsCursorHintActive(InstanceRef) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
                    return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 4)
                else
                    return false
                end
            end
        },
        {
            stateName = "Active_NoImage",
            condition = function(HudRef, ItemRef, UpdateTable)
                if IsCursorHintActive(InstanceRef) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
                Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
                    return IsModelValueEqualTo(InstanceRef, "hudItems.cursorHintIconRatio", 0)
                else
                    return false
                end
            end
        }
    }
    HudRef.CursorHint:mergeStateConditions(HudRef.CursorHint.StateTable)
    
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT)
    SubscribeToVisibilityBit(InstanceRef, HudRef, HudRef.CursorHint, Enum.UIVisibilityBit.BIT_UI_ACTIVE)

    SubscribeToModelAndUpdateState(InstanceRef, HudRef, HudRef.CursorHint, "hudItems.showCursorHint")
    SubscribeToModelAndUpdateState(InstanceRef, HudRef, HudRef.CursorHint, "hudItems.cursorHintIconRatio")
    
    HudRef.ConsoleCenter = CoD.CenterConsole.new(HudRef, InstanceRef)
    HudRef.ConsoleCenter:setLeftRight(false, false, -370, 370)
    HudRef.ConsoleCenter:setTopBottom(true, false, 68.5, 166.5)
    HudRef:addElement(HudRef.ConsoleCenter)
    
    HudRef.DeadSpectate = CoD.DeadSpectate.new(HudRef, InstanceRef)
    HudRef.DeadSpectate:setLeftRight(false, false, -150, 150)
    HudRef.DeadSpectate:setTopBottom(false, true, -180, -120)
    HudRef:addElement(HudRef.DeadSpectate)
    
    HudRef.MPScore = CoD.MPScr.new(HudRef, InstanceRef)
    HudRef.MPScore:setLeftRight(false, false, -50, 50)
    HudRef.MPScore:setTopBottom(true, false, 233.5, 258.5)
    HudRef:addElement(HudRef.MPScore)
    
    HudRef:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", function(ModelRef)
        if IsParamModelEqualToString(ModelRef, "score_event") then
            PlayClipOnElement(HudRef, {elementName = "MPScore",  clipName = "NormalScore"}, InstanceRef)
            SetMPScoreText(HudRef, HudRef.MPScore, InstanceRef, ModelRef)
        end
    end)
    
    HudRef.ZMPrematchCountdown0 = CoD.ZM_PrematchCountdown.new(HudRef, InstanceRef)
    HudRef.ZMPrematchCountdown0:setLeftRight(false, false, -640, 640)
    HudRef.ZMPrematchCountdown0:setTopBottom(false, false, -360, 360)
    HudRef:addElement(HudRef.ZMPrematchCountdown0)

    HudRef.ScoreboardWidget = CoD.ScoreboardWidgetCP.new(HudRef, InstanceRef)
    HudRef.ScoreboardWidget:setLeftRight(false, false, -503, 503)
    HudRef.ScoreboardWidget:setTopBottom(true, false, 247, 773)
    HudRef.ScoreboardWidget:setAlpha(0)
    HudRef:addElement(HudRef.ScoreboardWidget)

    HudRef.IngameChatClientContainer = CoD.IngameChatClientContainer.new(HudRef, InstanceRef)
    HudRef.IngameChatClientContainer:setLeftRight(true, false, 0, 360)
    HudRef.IngameChatClientContainer:setTopBottom(true, false, -2.5, 717.5)
    HudRef:addElement(HudRef.IngameChatClientContainer)
    
    HudRef.IngameChatClientContainer0 = CoD.IngameChatClientContainer.new(HudRef, InstanceRef)
    HudRef.IngameChatClientContainer0:setLeftRight(true, false, 0, 360)
    HudRef.IngameChatClientContainer0:setTopBottom(true, false, -2.5, 717.5)
    HudRef:addElement(HudRef.IngameChatClientContainer0)

    local SideQuestWidget = CoD.SidequestIconInventoryWidget.new(HudRef, InstanceRef)
    SideQuestWidget:setLeftRight(false, false, -201.500000, 201.500000)
    SideQuestWidget:setTopBottom(false, true, -106.000000, -12.000000)
    HudRef:addElement(SideQuestWidget)
    HudRef.SidequestIconInventoryWidget = SideQuestWidget

    HudRef.SidequestNotificationList = LUI.GridLayout.new(HudRef, InstanceRef, false, 0, 0, 2, 0, nil, nil, false, false, 0, 0, false, false)
    HudRef.SidequestNotificationList:setLeftRight(true, false, -2, 94)
    HudRef.SidequestNotificationList:setTopBottom(false, false, -344.5, 45.5)
    HudRef.SidequestNotificationList:setScale(0.87)
    HudRef.SidequestNotificationList:setWidgetType(CoD.SidequestIconNotificationWidget)
    HudRef.SidequestNotificationList:setVerticalCount(4)
    HudRef.SidequestNotificationList:setDataSource("ZMSidequestIconList")
    HudRef:addElement(HudRef.SidequestNotificationList)

    HudRef.SidequestNotificationList.StateTable = {
        {
            stateName = "Scoreboard",
            condition = function(HudRef, ItemRef, UpdateTable)
                return false
            end
        }
    }
    HudRef.SidequestNotificationList:mergeStateConditions(HudRef.SidequestNotificationList.StateTable)
        
    CoD.Menu.AddNavigationHandler(HudRef, HudRef, InstanceRef)
    
    HudRef:registerEventHandler("menu_loaded", function(Sender, Event)
        SizeToSafeArea(Sender, InstanceRef)
        return Sender:dispatchEventToChildren(Event)
    end)
    
    -- Not sure why these are explicitly set, but they are
    -- These are set because navigation won't work without setting id property!
    HudRef.ScoreboardWidget.id = "ScoreboardWidget"
    
    HudRef:processEvent({name = "menu_loaded", controller = InstanceRef})
    HudRef:processEvent({name = "update_state", menu = HudRef})
    
    if not HudRef:restoreState() then
        HudRef.ScoreboardWidget:processEvent({name = "gain_focus", controller = InstanceRef})
    end

    SubscribeToModelByName(HudRef, InstanceRef, "hudItems.playerSpawned", function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            if Engine.GetModelValue(ModelRef) == true then
                HudRef.T6Ammo:setAlpha(0)
                HudRef.T6Ammo:beginAnimation("keyframe", 8000, true, true, CoD.TweenType.Linear)
                HudRef.T6Ammo:registerEventHandler("transition_complete_keyframe", function(Sender, Event)
                    HudRef.T6Ammo:beginAnimation("keyframe", 600, true, true, CoD.TweenType.Linear)
                    HudRef.T6Ammo:setAlpha(1)
                    HudRef.T6Ammo:registerEventHandler("transition_complete_keyframe", nil)
                end)

                HudRef.T6Score:setAlpha(0)
                HudRef.T6Score:beginAnimation("keyframe", 8000, true, true, CoD.TweenType.Linear)
                HudRef.T6Score:registerEventHandler("transition_complete_keyframe", function(Sender, Event)
                    HudRef.T6Score:beginAnimation("keyframe", 600, true, true, CoD.TweenType.Linear)
                    HudRef.T6Score:setAlpha(1)
                    HudRef.T6Score:registerEventHandler("transition_complete_keyframe", nil)
                end)
            end
        end
    end)

    LUI.OverrideFunction_CallOriginalSecond(HudRef, "close", function(HudRef)
        HudRef.ZMPerksContainerFactory:close()
        HudRef.Rounds:close()
        HudRef.fullscreenContainer:close()
        HudRef.CursorHint:close()
        HudRef.ConsoleCenter:close()
        HudRef.DeadSpectate:close()
        HudRef.MPScore:close()
        HudRef.ZMPrematchCountdown0:close()
        HudRef.ScoreboardWidget:close()
        HudRef.IngameChatClientContainer:close()
        HudRef.IngameChatClientContainer0:close()
        HudRef.SidequestIconInventoryWidget:close()
        HudRef.SidequestNotificationList:close()

        HudRef.T6Ammo:close()
        HudRef.T6Score:close()
        
        Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "T7Hud_zm_factory.buttonPrompts"))
    end)
    
    if PostLoadCallback then
        PostLoadCallback(HudRef, InstanceRef)
    end

    return HudRef
end