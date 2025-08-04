require( "ui.uieditor.widgets.HUD.Waypoint.GenericWaypointContainer" )
require( "ui.uieditor.widgets.MPHudWidgets.WaypointBase" )
require( "ui.lilrifautils" )

require("ui.uieditor.widgets.DynamicContainerWidget")
require("ui.uieditor.widgets.Notifications.Notification")
require("ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotifBGB_ContainerFactory")
require("ui.uieditor.widgets.HUD.CenterConsole.CenterConsole")
require("ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate")
require("ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr")
require("ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown")
require("ui.uieditor.widgets.HUD.ZM_TimeBar.ZM_BeastmodeTimeBarWidget")
require("ui.uieditor.widgets.ZMInventory.RocketShieldBluePrint.RocketShieldBlueprintWidget")
require("ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer")
require("ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame")

require("ui.uieditor.widgets.hud.T5.T5AmmoWidget.T5AmmoWidget")
require("UI.UIEditor.Widgets.HUD.T5.T5PerkWidget.T5PerksWidget")
require("ui.uieditor.widgets.HUD.T5.T5RoundWidget.T5RoundStatus")
require("ui.uieditor.widgets.HUD.T5.T5ScoreWidget.T5ScoreWidget")
require("ui.uieditor.widgets.HUD.T5.T5ScoreBoardWidget.T5ScoreBoardWidget")
require("ui.uieditor.widgets.HUD.T5.T5HintString.T5HintString")
require("ui.uieditor.widgets.HUD.T5.T5ReviveWidget.T5ReviveWidget")

require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconInventoryWidget")
require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconNotificationWidget")

CoD.Zombie.CommonHudRequire()

DataSources.ZMInventory = {
    getModel = function ( controller )
        return Engine.GetModel( Engine.GetModelForController( controller ), "zmInventory" )
    end
}

-- if you have stuff from Shadows you need to add, check the definition of CoD.Zombies.InitInventoryUIModels for a giant list of ui models.
local function InitInventoryUIModels( controller )
    local f10_local0 = Engine.GetCurrentMap()
    local f10_local1 = DataSources.ZMInventory.getModel( controller )
    Engine.SetModelValue( Engine.CreateModel( f10_local1, "shield_health" ), 1 )
    Engine.SetModelValue( Engine.CreateModel( f10_local1, "super_ee" ), 0 )
    local f10_local2 = function ( f12_arg0, f12_arg1 )
        local f12_local0 = function ( f13_arg0, f13_arg1 )
            if CoD.Zombie.fastRestart or not Engine.GetModel( f13_arg0, f13_arg1 ) then
                Engine.SetModelValue( Engine.CreateModel( f13_arg0, f13_arg1 ), 0 )
            end
        end
        
        local f12_local1 = Engine.CreateModel( Engine.GetModelForController( f12_arg0 ), "sidequestIcons" )
        for f12_local10, f12_local11 in ipairs( f12_arg1 ) do
            if f12_local11.clientfield then
                f12_local0( f12_local1, f12_local11.clientfield .. ".icon" )
                f12_local0( f12_local1, f12_local11.clientfield .. ".notification" )
            end
            for f12_local8, f12_local9 in ipairs( f12_local11 ) do
                f10_local2( f12_arg0, f12_local9 )
            end
        end
    end

    for f10_local7, f10_local8 in ipairs( {
        "widget_shield_parts",
        "piece_riotshield_dolly",
        "piece_riotshield_door",
        "piece_riotshield_clamp"
    } ) do
        if CoD.Zombie.fastRestart or not Engine.GetModel( f10_local1, f10_local8 ) then
            Engine.SetModelValue( Engine.CreateModel( f10_local1, f10_local8 ), 0 )
        end
    end

    CoD.Zombie.SidequestIcons = { 
        { 
            clientfield = "uie_t7_zm_hud_score_char1", 
            icon = "uie_t7_zm_hud_score_char1"
        }, 
        {
            clientfield = "uie_t7_zm_hud_score_char2", 
            icon = "uie_t7_zm_hud_score_char2"
        }, 
        {
            clientfield = "uie_t7_zm_hud_score_char3", 
            icon = "uie_t7_zm_hud_score_char3"
        },
        {
            clientfield = "uie_t7_zm_hud_score_char4", 
            icon = "uie_t7_zm_hud_score_char4"
        }
    }

    f10_local2( controller, CoD.Zombie.SidequestIcons )
end

CoD.GetCachedObjective = function(ObjectiveName)
    if ObjectiveName == nil then
        return nil
    elseif CoD.Zombie.ObjectivesTable[ObjectiveName] ~= nil then
        return CoD.Zombie.ObjectivesTable[ObjectiveName]
    end

    local ObjectiveInfo = Engine.GetObjectiveInfo(ObjectiveName)
    if ObjectiveInfo ~= nil then
        CoD.Zombie.ObjectivesTable[ObjectiveName] = ObjectiveInfo
    end

    return ObjectiveInfo
end

local function PreLoadCallback(HudRef, InstanceRef)
    local ControllerModel = Engine.GetModelForController(InstanceRef)
    Engine.CreateModel(ControllerModel, "bgb_current")
    Engine.CreateModel(ControllerModel, "bgb_display")
    Engine.CreateModel(ControllerModel, "bgb_timer")
    Engine.CreateModel(ControllerModel, "bgb_activations_remaining")
    Engine.CreateModel(ControllerModel, "bgb_invalid_use")
    Engine.CreateModel(ControllerModel, "bgb_one_shot_use")
    Engine.CreateModel(ControllerModel, "zmhud.swordEnergy")
    Engine.CreateModel(ControllerModel, "zmhud.swordState")

    HudRef:subscribeToModel(Engine.CreateModel(Engine.GetGlobalModel(), "fastRestart"), function(ModelRef)
        CoD.Zombie.fastRestart = true
        --CoD.Zombie.InitInventoryUIModels(InstanceRef)
        InitInventoryUIModels( InstanceRef )
        CoD.Zombie.fastRestart = nil
    end, false)

    --CoD.Zombie.InitInventoryUIModels(InstanceRef)
    InitInventoryUIModels( InstanceRef )
end


local function PostLoadCallback(HudRef, InstanceRef)
    local WorldSpaceIndicatorsModel = DataSources.WorldSpaceIndicators.getModel(InstanceRef)
    CoD.TacticalModeUtility.CreateShooterSpottedWidgets(HudRef, InstanceRef)

    if WorldSpaceIndicatorsModel then
        local function AssignPlayerNamesToBleedoutPrompts(FullscreenContainer)
            local child = FullscreenContainer:getFirstChild()
            while child do
                if LUI.startswith(child.id, "bleedOutItem") then
                    local playerNameModel = child:getModel(InstanceRef, "playerName")
                    if playerNameModel then
                        Engine.SetModelValue(playerNameModel, Engine.GetGamertagForClient(InstanceRef, child.bleedOutClient))
                    end
                end

                child = child:getNextSibling()
            end
        end

        local clientNum = 0
        local keepAddingBleedOutClients = true
        while keepAddingBleedOutClients do
            local clientBleedOutModel = Engine.CreateModel(WorldSpaceIndicatorsModel, "bleedOutModel" .. clientNum)
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "playerName"), Engine.GetGamertagForClient(InstanceRef, clientNum))
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "prompt"), "ZMUI_REVIVE")
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "clockPercent"), 0)
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "bleedOutPercent"), 0)
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "stateFlags"), 0)
            Engine.SetModelValue(Engine.CreateModel(clientBleedOutModel, "arrowAngle"), 0)
            
            local ZMReviveWidget = CoD.ZM_Revive.new(HudRef, InstanceRef)
            ZMReviveWidget.bleedOutClient = clientNum
            ZMReviveWidget.id = "bleedOutItem" .. clientNum
            ZMReviveWidget:setLeftRight(true, false, 0, 0)
            ZMReviveWidget:setTopBottom(true, false, 0, 0)
            ZMReviveWidget:setModel(clientBleedOutModel)
            keepAddingBleedOutClients = ZMReviveWidget:setupBleedOutWidget(InstanceRef, clientNum)
            ZMReviveWidget:processEvent({
                name = "update_state",
                menu = HudRef
            })
            HudRef.fullscreenContainer:addElement(ZMReviveWidget)

            HudRef.fullscreenContainer:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "playerConnected"), function(ModelRef)
                AssignPlayerNamesToBleedoutPrompts(HudRef.fullscreenContainer)
            end)
            ZMReviveWidget:setAlpha(0)
            clientNum = clientNum + 1
        end
    end

    HudRef.m_inputDisabled = true

    if LUI.DEV ~= nil then
        if LUI.DEVHideButtonPrompts then
            HudRef.CursorHint:setAlpha(0)
        end
        HudRef:registerEventHandler("hide_button_prompts", function(Sender, Event)
            Sender.CursorHint:setAlpha(Event.show and 1 or 0)
        end)
    end

    local function HandleWaypointObjective(WaypointBase, ObjectiveTable)
        local InstanceRef = ObjectiveTable.controller
        local objectiveName = Engine.GetObjectiveName(ObjectiveTable.controller, ObjectiveTable.objId)
        local objectiveInfo = CoD.GetCachedObjective(objectiveName)
        if objectiveInfo == nil then
            return
        elseif Dvar.cg_luiDebug:get() == true then
            DebugPrint("Waypoint ID " .. ObjectiveTable.objId .. ": " .. objectiveName .. ": " .. #WaypointBase.WaypointContainerList .. " waypoints active")
        end

        if not WaypointBase.savedStates then
            WaypointBase.savedStates = {}
            WaypointBase.savedEntNums = {}
            WaypointBase.savedObjectiveNames = {}
            WaypointBase.savedTeam = -1
            WaypointBase.savedRound = -1
        end

        local objectiveState = Engine.GetObjectiveState(InstanceRef, ObjectiveTable.objId)
        local objectiveSavedState = WaypointBase.savedStates[ObjectiveTable.objId]
        if not objectiveSavedState then
            objectiveSavedState = CoD.OBJECTIVESTATE_EMPTY
        end

        local ControllerModel = Engine.GetModelForController(ObjectiveTable.controller)
        local objectiveModel = Engine.GetModel(ControllerModel, "objective" .. ObjectiveTable.objId)
        
        local objectiveStateModel = nil
        if objectiveModel == 0 then
            objectiveStateModel = objectiveModel
        else
            objectiveStateModel = Engine.GetModel(objectiveModel, "state")
        end

        local objectiveEntNum = CoD.SafeGetModelValue(objectiveModel, "entNum")
        local objectiveTeamID = CoD.GetTeamID(InstanceRef)
        local objectiveRoundsPlayed = Engine.GetRoundsPlayed(InstanceRef)

        if objectiveTeamID ~= WaypointBase.savedTeam or objectiveRoundsPlayed ~= WaypointBase.savedRound then
            WaypointBase.savedStates = {}
            WaypointBase.savedEntNums = {}
            WaypointBase.savedObjectiveNames = {}
        end

        if not CoD.isCampaign and Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED) and objectiveState == objectiveSavedState and objectiveEntNum == WaypointBase.savedEntNums[ObjectiveTable.objId] and objectiveName == WaypointBase.savedObjectiveNames[ObjectiveTable.objId] then
            if objectiveStateModel ~= nil then
                Engine.ForceNotifyModelSubscriptions(objectiveStateModel)
            end
            return
        elseif objectiveStateModel ~= nil then
            local objectiveState = Engine.GetModelValue(objectiveStateModel)
            Engine.SetModelValue(objectiveStateModel, CoD.OBJECTIVESTATE_EMPTY)
            Engine.SetModelValue(objectiveStateModel, objectiveState)
        end
        
        WaypointBase.savedStates[ObjectiveTable.objId] = objectiveState
        WaypointBase.savedEntNums[ObjectiveTable.objId] = objectiveEntNum
        WaypointBase.savedObjectiveNames[ObjectiveTable.objId] = objectiveName
        WaypointBase.savedTeam = objectiveTeamID
        WaypointBase.savedRound = objectiveRoundsPlayed

        if objectiveName then
            local WaypointWidgetContainer = CoD.WaypointWidgetContainer.new(WaypointBase, ObjectiveTable.controller)
            WaypointWidgetContainer.objective = objectiveInfo

            WaypointWidgetContainer.setupWaypoint = function(WaypointWidgetContainer, ObjectiveTable)
                if WaypointWidgetContainer.objective.id == "t5waypoint_revive0" or 
                    WaypointWidgetContainer.objective.id == "t5waypoint_revive1" or 
                    WaypointWidgetContainer.objective.id == "t5waypoint_revive2" or 
                    WaypointWidgetContainer.objective.id == "t5waypoint_revive3" then
                        
                    WaypointWidgetContainer.gameTypeContainer = CoD.T5ReviveWidget.new(WaypointWidgetContainer.menu, ObjectiveTable.controller)
                    WaypointWidgetContainer.gameTypeContainer:setLeftRight(true, true, 0, 0)
                    WaypointWidgetContainer.gameTypeContainer:setTopBottom(true, true, 0, 0)
                    WaypointWidgetContainer:addElement(WaypointWidgetContainer.gameTypeContainer)
                end

                WaypointWidgetContainer.gameTypeContainer.objective = WaypointWidgetContainer.objective
                WaypointWidgetContainer.gameTypeContainer:setupWaypointContainer(ObjectiveTable)
            end
            
            WaypointWidgetContainer:setupWaypoint(ObjectiveTable)
            WaypointWidgetContainer:setLeftRight(true, true, 0, 0)
            WaypointWidgetContainer:setTopBottom(true, true, 0, 0)
            WaypointBase:addElement(WaypointWidgetContainer)
            table.insert(WaypointBase.WaypointContainerList, WaypointWidgetContainer)

            WaypointWidgetContainer:update(ObjectiveTable)
            WaypointWidgetContainer:setModel(objectiveModel)

            WaypointWidgetContainer:subscribeToModel(objectiveStateModel, function(ModelRef)
                local objectiveState = Engine.GetModelValue(ModelRef)
                WaypointBase.savedStates[ObjectiveTable.objId] = objectiveState
                if objectiveState == CoD.OBJECTIVESTATE_ACTIVE or objectiveState == CoD.OBJECTIVESTATE_CURRENT or objectiveState == CoD.OBJECTIVESTATE_DONE then
                    WaypointWidgetContainer:show()
                    WaypointWidgetContainer:update({
                        controller = InstanceRef,
                        objState = objectiveState
                    })
                elseif objectiveState == CoD.OBJECTIVESTATE_EMPTY then
                    WaypointBase:removeWaypoint(ObjectiveTable.objId)
                    WaypointBase.savedEntNums[ObjectiveTable.objId] = nil
                else
                    WaypointWidgetContainer:hide()
                end
            end)
            
            local updateTimeModel = Engine.GetModel(objectiveModel, "updateTime")
            if updateTimeModel ~= nil then
                WaypointWidgetContainer:subscribeToModel(updateTimeModel, function(ModelRef)
                    WaypointWidgetContainer:update({
                        controller = InstanceRef
                    })
                end)
            end

            WaypointWidgetContainer:subscribeToModel(Engine.GetModel(objectiveModel, "progress"), function(ModelRef)
                WaypointWidgetContainer:update({
                    controller = InstanceRef,
                    progress = Engine.GetModelValue(ModelRef)
                })
            end)

            WaypointWidgetContainer:subscribeToModel(Engine.GetModel(objectiveModel, "clientUseMask"), function(ModelRef)
                WaypointWidgetContainer:update({
                    controller = InstanceRef,
                    clientUseMask = Engine.GetModelValue(ModelRef)
                })
            end)

            local colorBlindModeModel = Engine.GetModel(ControllerModel, "profile.colorBlindMode")
            if colorBlindModeModel then
                WaypointWidgetContainer:subscribeToModel(colorBlindModeModel, function(ModelRef)
                    WaypointWidgetContainer:update({
                        controller = InstanceRef
                    })
                end, false)
            end
        end

        return true
    end

    HudRef.WaypointBase.WaypointContainerList = {}

    CoD.Zombie.ObjectivesTable = Engine.BuildObjectivesTable()
    if CoD.Zombie.ObjectivesTable == nil or #CoD.Zombie.ObjectivesTable == 0 then
        error("LUI Error: Failed to load objectives.json!")
    end

    for index = #CoD.Zombie.ObjectivesTable, 1, -1 do
        local objectiveTable = CoD.Zombie.ObjectivesTable[index]
        CoD.Zombie.ObjectivesTable[objectiveTable.id] = objectiveTable
        table.remove(CoD.Zombie.ObjectivesTable, index)
    end

    HudRef:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "newObjectiveType" .. Enum.ObjectiveTypes.OBJECTIVE_TYPE_WAYPOINT), function(ModelRef)
        HandleWaypointObjective(HudRef.WaypointBase, {
            controller = InstanceRef,
            objId = Engine.GetModelValue(ModelRef),
            objType = Enum.ObjectiveTypes.OBJECTIVE_TYPE_WAYPOINT
        })
    end, false)
end

function LUI.createMenu.T5Hud_zm_factory(InstanceRef)
    local HudRef = CoD.Menu.NewForUIEditor("T5Hud_zm_factory")
    
    if PreLoadCallback then
        PreLoadCallback(HudRef, InstanceRef)
    end
    
    HudRef.soundSet = "HUD"
    HudRef:setOwner(InstanceRef)
    HudRef:setLeftRight(true, true, 0, 0)
    HudRef:setTopBottom(true, true, 0, 0)
    HudRef:playSound("menu_open", InstanceRef)
    
    HudRef.buttonModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "T5Hud_zm_factory.buttonPrompts")
    HudRef.anyChildUsesUpdateState = true
    
    local PerksWidget = CoD.T5PerksWidget.new(HudRef, InstanceRef)
    PerksWidget:setLeftRight(true, true, 0.0, 0.0)
    PerksWidget:setTopBottom(true, true, 0.0, 0.0)
    
    HudRef:addElement(PerksWidget)
    HudRef.PerksWidget = PerksWidget
    
    local RoundCounter = LUI.createMenu.RoundStatus(InstanceRef)
    
    HudRef:addElement(RoundCounter)
    HudRef.Rounds = RoundCounter
    
    local AmmoWidget = CoD.T5AmmoWidget.new(HudRef, InstanceRef)
    AmmoWidget:setLeftRight(true, true, 0.0, 0.0)
    AmmoWidget:setTopBottom(true, true, 0.0, 0.0)
    
    HudRef:addElement(AmmoWidget)
    HudRef.Ammo = AmmoWidget
    
    local ScoreWidget = CoD.T5ScoreWidget.new(HudRef, InstanceRef)
    ScoreWidget:setLeftRight(true, true, 0.0, 0.0)
    ScoreWidget:setTopBottom(true, true, 0.0, 0.0)
    
    HudRef:addElement(ScoreWidget)
    HudRef.Score = ScoreWidget
    
    local DynaWidget = CoD.DynamicContainerWidget.new(HudRef, InstanceRef)
    DynaWidget:setLeftRight(false, false, -640.0, 640.0)
    DynaWidget:setTopBottom(false, false, -360.0, 360.0)
    
    HudRef:addElement(DynaWidget)
    HudRef.fullscreenContainer = DynaWidget
    
    local NotificationWidget = CoD.Notification.new(HudRef, InstanceRef)
    NotificationWidget:setLeftRight(true, true, 0.0, 0.0)
    NotificationWidget:setTopBottom(true, true, 0.0, 0.0)
    
    HudRef:addElement(NotificationWidget)
    HudRef.Notifications = NotificationWidget
    
    local GumWidget = CoD.ZmNotifBGB_ContainerFactory.new(HudRef, InstanceRef)
    GumWidget:setLeftRight(false, false, -156.0, 156.0)
    GumWidget:setTopBottom(true, false, -6.0, 247.0)
    GumWidget:setScale(0.750000)
    
    local function GumCallback(ModelRef)
        if IsParamModelEqualToString(ModelRef, "zombie_bgb_token_notification") then
            AddZombieBGBTokenNotification(HudRef, GumWidget, InstanceRef, ModelRef) -- Add a popup for a 'free hit'
        elseif IsParamModelEqualToString(ModelRef, "zombie_bgb_notification") then
            AddZombieBGBNotification(HudRef, GumWidget, ModelRef) -- Add a popup for the gum you got
        elseif IsParamModelEqualToString(ModelRef, "zombie_notification") then
            AddZombieNotification(HudRef, GumWidget, ModelRef) -- Add a popup for a powerup
        end
    end
    
    GumWidget:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", GumCallback)
    
    HudRef:addElement(GumWidget)
    HudRef.ZmNotifBGBContainerFactory = GumWidget

    HudRef.GenericWaypointContainer = CoD.GenericWaypointContainer.new(HudRef, InstanceRef)
    HudRef.GenericWaypointContainer:setLeftRight(false, false, -640, 640)
    HudRef.GenericWaypointContainer:setTopBottom(false, false, -360, 360)
    HudRef.GenericWaypointContainer:setAlpha(0)
    HudRef:addElement(HudRef.GenericWaypointContainer)

    HudRef.WaypointBase = CoD.WaypointBase.new(HudRef, InstanceRef)
    HudRef.WaypointBase:setLeftRight(false, false, -640, 640)
    HudRef.WaypointBase:setTopBottom(false, false, -360, 360)
    HudRef:addElement(HudRef.WaypointBase)
    
    HudRef.WaypointBase:registerEventHandler("menu_loaded", function(Sender, Event)
        SizeToSafeArea(Sender, InstanceRef)
        return Sender:dispatchEventToChildren(Event)
    end)
    
    local HintWidget = CoD.T5HintString.new(HudRef, InstanceRef)
    HintWidget:setLeftRight(false, false, -250.0, 250.0)
    HintWidget:setTopBottom(true, false, 400.0, 500.0)
    
    local function ActiveState1x1(Unk1, Unk2, Unk3)
        if IsCursorHintActive(InstanceRef) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
            return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 1.0)
        else
            return false
        end
    end
    
    local function ActiveState2x1(Unk1, Unk2, Unk3)
        if IsCursorHintActive(InstanceRef) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
            return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 2.0)
        else
            return false
        end
    end
    
    local function ActiveState4x1(Unk1, Unk2, Unk3)
        if IsCursorHintActive(InstanceRef) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
            return (Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) == 4.0)
        else
            return false
        end
    end
    
    local function ActiveStateNoImg(Unk1, Unk2, Unk3)
        if IsCursorHintActive(InstanceRef) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
            return IsModelValueEqualTo(InstanceRef, "hudItems.cursorHintIconRatio", 0.0)
        else
            return false
        end
    end
    
    HintWidget:mergeStateConditions({
        {stateName = "Active_1x1", condition = ActiveState1x1},
        {stateName = "Active_2x1", condition = ActiveState2x1},
        {stateName = "Active_4x1", condition = ActiveState4x1},
        {stateName = "Active_NoImage", condition = ActiveStateNoImg}
    })
    
    local CursorController = Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.showCursorHint")
    
    local function ShowCallback(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "hudItems.showCursorHint"})
    end
    
    HintWidget:subscribeToModel(CursorController, ShowCallback)
    
    local function CursorBitHardcore(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
    end    

    local function CursorBitVisible(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
    end
    
    local function CursorBitMissile(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
    end
    
    local function CursorBitDemo(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING})
    end
    
    local function CursorBitFlash(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
    end
    
    local function CursorBitMap(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK})
    end
    
    local function CursorBitSpectating(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT})
    end
    
    local function CursorBitActive(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
    end
    
    local function CursorRatioChange(ModelRef)
        HudRef:updateElementState(HintWidget, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "hudItems.cursorHintIconRatio"})
    end
    
    -- This widget reacts to these controller changes
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), CursorBitHardcore)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), CursorBitVisible)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), CursorBitMissile)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING), CursorBitDemo)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), CursorBitFlash)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK), CursorBitMap)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT), CursorBitSpectating)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), CursorBitActive)
    HintWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.cursorHintIconRatio"), CursorRatioChange)
    
    HudRef:addElement(HintWidget)
    HudRef.CursorHint = HintWidget
    
    local CenterCon = CoD.CenterConsole.new(HudRef, InstanceRef)
    CenterCon:setLeftRight(false, false, -370.0, 370.0)
    CenterCon:setTopBottom(true, false, 68.500000, 166.500000)
    
    HudRef:addElement(CenterCon)
    HudRef.ConsoleCenter = CenterCon
    
    local DeadOverlay = CoD.DeadSpectate.new(HudRef, InstanceRef)
    DeadOverlay:setLeftRight(false, false, -150.0, 150.0)
    DeadOverlay:setTopBottom(false, true, -180.0, -120.0)
    
    HudRef:addElement(DeadOverlay)
    HudRef.DeadSpectate = DeadOverlay
    
    local ScoreBd = CoD.MPScr.new(HudRef, InstanceRef)
    ScoreBd:setLeftRight(false, false, -50.0, 50.0)
    ScoreBd:setTopBottom(true, false, 233.500000, 258.500000)
    
    local function MpCallback(ModelRef)
        if IsParamModelEqualToString(ModelRef, "score_event") then
            PlayClipOnElement(HudRef, {elementName = "MPScore",  clipName = "NormalScore"}, InstanceRef)
            SetMPScoreText(HudRef, ScoreBd, InstanceRef, ModelRef)
        end
    end
    
    HudRef:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", MpCallback)
    
    HudRef:addElement(ScoreBd)
    HudRef.MPScore = ScoreBd
    
    local PreMatch = CoD.ZM_PrematchCountdown.new(HudRef, InstanceRef)
    PreMatch:setLeftRight(false, false, -640.0, 640.0)
    PreMatch:setTopBottom(false, false, -360.0, 360.0)
    
    HudRef:addElement(PreMatch)
    HudRef.ZMPrematchCountdown0 = PreMatch
    
    local ScoreCP = CoD.T5ScoreBoardWidget.new(HudRef, InstanceRef)
    ScoreCP:setLeftRight(false, false, -400.0, 400.0)
    ScoreCP:setTopBottom(true, false, 247.0, 773.0)
    
    HudRef:addElement(ScoreCP)
    HudRef.ScoreboardWidget = ScoreCP
    
    local BeastTimer = CoD.ZM_BeastmodeTimeBarWidget.new(HudRef, InstanceRef)
    HudRef:setLeftRight(false, false, -242.500000, 321.500000)
    HudRef:setTopBottom(false, true, -174.0, -18.0)
    
    HudRef:addElement(BeastTimer)
    HudRef.ZMBeastBar = BeastTimer
    
    local ShieldWidget = CoD.RocketShieldBlueprintWidget.new(HudRef, InstanceRef)
    ShieldWidget:setLeftRight(true, false, -36.500000, 277.500000)
    ShieldWidget:setTopBottom(true, false, 104.0, 233.0)
    ShieldWidget:setScale(0.800000)
    
    local function ShieldCallback(Unk1, Unk2, Unk3)
        if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) then end
        return AlwaysFalse() -- Because the shield isn't available...
    end
    
    ShieldWidget:mergeStateConditions({{stateName = "Scoreboard", condition = ShieldCallback}})
    
    local function ShieldParts(ModelRef)
        HudRef:updateElementState(ShieldWidget, {name = "model_validation",
            menu = HudRef, menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "zmInventory.widget_shield_parts"})
    end
    
    local function ShieldBitOpen(ModelRef)
        HudRef:updateElementState(ShieldWidget, {name = "model_validation", 
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
    end
    
    ShieldWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "zmInventory.widget_shield_parts"), ShieldParts)
    ShieldWidget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), ShieldBitOpen)
    
    HudRef:addElement(ShieldWidget)
    HudRef.RocketShieldBlueprintWidget = ShieldWidget
    
    local ChatContainer = CoD.IngameChatClientContainer.new(HudRef, InstanceRef)
    ChatContainer:setLeftRight(true, false, 0.0, 360.0)
    ChatContainer:setTopBottom(true, false, -2.500000, 717.500000)
    
    HudRef:addElement(ChatContainer)
    HudRef.IngameChatClientContainer = ChatContainer
    
    local ChatContainer2 = CoD.IngameChatClientContainer.new(HudRef, InstanceRef)
    ChatContainer2:setLeftRight(true, false, 0.0, 360.0)
    ChatContainer2:setTopBottom(true, false, -2.500000, 717.500000)
    
    HudRef:addElement(ChatContainer2)
    HudRef.IngameChatClientContainer0 = ChatContainer2

    local SideQuestWidget = CoD.SidequestIconInventoryWidget.new(HudRef, InstanceRef)
    SideQuestWidget:setLeftRight(false, false, -201.500000, 201.500000)
    SideQuestWidget:setTopBottom(false, true, -106.000000, -12.000000)

    HudRef:addElement(SideQuestWidget)
    HudRef.SidequestIconInventoryWidget = SideQuestWidget

    HudRef.SidequestIconInventoryWidget.StateTable = {
        {
            -- you can either use Show1, Show3 or Show4
            stateName = "Show4",
            condition = function ( menu, element, event )
                local IsScoreBoardOpen = Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
                return IsScoreBoardOpen
            end
        },
    }

    HudRef.SidequestIconInventoryWidget:mergeStateConditions( HudRef.SidequestIconInventoryWidget.StateTable )

    local SidequestNotificationList = LUI.GridLayout.new(HudRef, InstanceRef, false, 0, 0, 2, 0, nil, nil, false, false, 0, 0, false, false)
    SidequestNotificationList:setLeftRight(true, false, -2, 94)
    SidequestNotificationList:setTopBottom(false, false, -344.5, 45.5)
    SidequestNotificationList:setScale(0.87)
    SidequestNotificationList:setWidgetType( CoD.SidequestIconNotificationWidget )
    SidequestNotificationList:setVerticalCount( #CoD.Zombie.SidequestIcons )
    SidequestNotificationList:setDataSource("ZMSidequestIconList")
    HudRef:addElement(SidequestNotificationList)

    SidequestNotificationList.StateTable = {
        {
            stateName = "Scoreboard",
            condition = function(HudRef, ItemRef, UpdateTable)
                return false
            end
        }
    }
    SidequestNotificationList:mergeStateConditions(SidequestNotificationList.StateTable)
    HudRef.SidequestNotificationList = SidequestNotificationList
    
    local GumPack = CoD.BubbleGumPackInGame.new(HudRef, InstanceRef)
    GumPack:setLeftRight(false, false, -184.0, 184.0)
    GumPack:setTopBottom(true, false, 36.0, 185.0)
    
    HudRef:addElement(GumPack)
    HudRef.BubbleGumPackInGame = GumPack
    
    CoD.Menu.AddNavigationHandler(HudRef, HudRef, InstanceRef)
    
    local function MenuLoadedCallback(HudObj, EventObj)
        SizeToSafeArea(HudObj, InstanceRef)
        return HudObj:dispatchEventToChildren(EventObj)
    end
    
    HudRef:registerEventHandler("menu_loaded", MenuLoadedCallback)
    
    -- Not sure why these are explicitly set, but they are
    -- These are set because navigation won't work without setting id property!
    HudRef.ScoreboardWidget.id = "T5ScoreBoardWidget"
    
    HudRef:processEvent({name = "menu_loaded", controller = InstanceRef})
    HudRef:processEvent({name = "update_state", menu = HudRef})
    
    if not HudRef:restoreState() then
        HudRef.ScoreboardWidget:processEvent({name = "gain_focus", controller = InstanceRef})
    end
    
    local function HudCloseCallback(SenderObj)
        SenderObj.PerksWidget:close()
        SenderObj.Rounds:close()
        SenderObj.Ammo:close()
        SenderObj.Score:close()
        SenderObj.fullscreenContainer:close()
        SenderObj.Notifications:close()
        SenderObj.ZmNotifBGBContainerFactory:close()
        SenderObj.CursorHint:close()
        SenderObj.ConsoleCenter:close()
        SenderObj.DeadSpectate:close()
        SenderObj.MPScore:close()
        SenderObj.ZMPrematchCountdown0:close()
        SenderObj.ScoreboardWidget:close()
        SenderObj.ZMBeastBar:close()
        SenderObj.RocketShieldBlueprintWidget:close()
        SenderObj.IngameChatClientContainer:close()
        SenderObj.IngameChatClientContainer0:close()
        SenderObj.BubbleGumPackInGame:close()
        SenderObj.WaypointBase:close()
        SenderObj.GenericWaypointContainer:close()
        
        Engine.GetModel(Engine.GetModelForController(InstanceRef), "T5Hud_zm_factory.buttonPrompts")
        Engine.UnsubscribeAndFreeModel()
    end
    
    LUI.OverrideFunction_CallOriginalSecond(HudRef, "close", HudCloseCallback)
    
    if PostLoadCallback then
        PostLoadCallback(HudRef, InstanceRef)
    end

    return HudRef
end

LUI.createMenu.T7Hud_ZM = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_factory = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_castle = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_island = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_stalingrad = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_genesis = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_dlc5 = LUI.createMenu.T5Hud_zm_factory
LUI.createMenu.T7Hud_zm_tomb = LUI.createMenu.T5Hud_zm_factory