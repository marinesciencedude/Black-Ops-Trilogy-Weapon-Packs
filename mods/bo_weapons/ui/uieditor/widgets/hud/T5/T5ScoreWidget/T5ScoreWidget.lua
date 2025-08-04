require( "UI.SubscriptionUtils" )

require("UI.UIEditor.Widgets.HUD.T5.T5ScoreWidget.T5SelfScoreWidget")
require("UI.UIEditor.Widgets.HUD.T5.T5ScoreWidget.T5ClientScoreWidget")

DataSources.PlayerListZM = {
    modelLinks = {
        playerName = "playerName",
        score = "playerScore",
        scoreVisible = "playerScoreVisible",
        rankIcon = "playerRankIcon",
        rankNum = "rankNum",
        clanAbbrev = "clanAbbrev",
        clientNum = "clientNum",
        playerConnected = "playerConnected",
        zombiePlayerIcon = "zombiePlayerIcon",
        zombieInventoryIcon = "zombieInventoryIcon",
        zombieWearableIcon = "zombieWearableIcon",
        playerScoreShown = "playerScoreShown"
    },
    prepare = function(controller, UIList, FilterFunc)
        UIList.playerSlots = {}
        UIList.playerListInfoList = {}

        local controllerModel = Engine.GetModelForController(controller)
        local playerListModel = Engine.CreateModel(controllerModel, "PlayerList")

        if UIList.modelSubscriptions then
            for clientIndex, modelSubscription in pairs(UIList.modelSubscriptions) do
                UIList:removeSubscription(modelSubscription)
            end
        end

        UIList.modelSubscriptions = {}

        local selfClientNum = Engine.GetClientNum(controller)

        local function GetAdjustedClientIndex(ClientIndex, SelfClientIndex)
            if ClientIndex == SelfClientIndex then
                return 1
            elseif ClientIndex < SelfClientIndex then
                return 2 + ClientIndex
            else
                return 1 + ClientIndex
            end
        end

        local function CacheModelDataAndResetModel(ControllerModel, ClientIndex, UIModelName, PlayerListData)
            local UIModel = Engine.GetModel(ControllerModel, "zmInventory.player" .. ClientIndex .. UIModelName)
            if UIModel then
                PlayerListData[UIModelName] = Engine.GetModelValue(UIModel)
                Engine.UnsubscribeAndFreeModel(UIModel)

                Engine.CreateModel(ControllerModel, "zmInventory.player" .. ClientIndex .. UIModelName)
            end
        end

        for clientIndex = 0, Dvar.com_maxclients:get() do
            local adjustedClientIndex = GetAdjustedClientIndex(clientIndex, selfClientNum)
            local playerListData = Engine.GetPlayerListData(controller, clientIndex)
            local playerSlotModel = Engine.CreateModel(playerListModel, adjustedClientIndex - 1)

            for modelName, modelValue in pairs(DataSources.PlayerListZM.modelLinks) do -- modelName == modelValue
                Engine.SetModelValue(Engine.CreateModel(playerSlotModel, modelValue), playerListData[modelName])
            end

            -- Add non-stock playerlist data --
            -- These are playerlist data items that are controlled through script with world clientfields that use zm_utility::setSharedInventoryUIModels in CSC to send the UIModel data
            CacheModelDataAndResetModel(controllerModel, clientIndex, "hasItem", playerListData)
            CacheModelDataAndResetModel(controllerModel, clientIndex, "wearableItem", playerListData)
            -- End add non-stock playerlist data

            if playerListData.playerConnected == 1 then
                UIList.playerSlots[adjustedClientIndex] = playerListData
            end

            UIList.playerListInfoList[adjustedClientIndex] = playerSlotModel
        end

        for adjustedClientIndex, playerSlotStruct in ipairs(UIList.playerSlots) do
            local playerSlotModel = Engine.CreateModel(playerListModel, adjustedClientIndex - 1) -- PlayerList.0, PlayerList.1, etc UIModels. These are the models that are assigned to corresponding list items
            for modelName, modelValue in pairs(DataSources.PlayerListZM.modelLinks) do -- modelName == modelValue
                Engine.SetModelValue(Engine.CreateModel(playerSlotModel, modelValue), playerSlotStruct[modelName])
            end

            -- Add non-stock playerlist data --
            if CoD.Zombie.InventoryIcon ~= nil then
                local hasItemModel = Engine.CreateModel(controllerModel, "zmInventory.player" .. playerSlotStruct.clientNum .. "hasItem")
                Engine.SetModelValue(hasItemModel, UIList.playerSlots[adjustedClientIndex].hasItem or 0)
                
                table.insert(UIList.modelSubscriptions, UIList:subscribeToModel(hasItemModel, function(ModelRef)
                    local ModelValue = Engine.GetModelValue(ModelRef)
                    if ModelValue == 0 then
                        Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieInventoryIcon"), "blacktransparent")
                    else
                        Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieInventoryIcon"), CoD.Zombie.InventoryIcon[ModelValue])
                    end
                end))
            else
                Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieInventoryIcon"), "blacktransparent")
            end

            if CoD.Zombie.WearableItems ~= nil then
                local wearableItemModel = Engine.CreateModel(controllerModel, "zmInventory.player" .. playerSlotStruct.clientNum .. "wearableItem")
                Engine.SetModelValue(wearableItemModel, UIList.playerSlots[adjustedClientIndex].wearableItem or 0)
                
                local function UpdateWearablesData()
                    local wearableItemImage = Engine.GetModelValue(Engine.CreateModel(controllerModel, "zmInventory.player" .. playerSlotStruct.clientNum .. "wearableItem"))
                    local zombiePlayerIcon = Engine.GetModelValue(Engine.GetModel(playerSlotModel, "zombiePlayerIcon"))

                    if not zombiePlayerIcon or wearableItemImage == 0 then
                        Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieWearableIcon"), "blacktransparent")
                    else
                        Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieWearableIcon"), zombiePlayerIcon .. "_" .. CoD.Zombie.WearableItems[wearableItemImage])
                    end
                end
                table.insert(UIList.modelSubscriptions, UIList:subscribeToModel(wearableItemModel, UpdateWearablesData))
                table.insert(UIList.modelSubscriptions, UIList:subscribeToModel(Engine.GetModel(playerSlotModel, "zombiePlayerIcon"), UpdateWearablesData, false))
            else
                Engine.SetModelValue(Engine.CreateModel(playerSlotModel, "zombieWearableIcon"), "blacktransparent")
            end
            -- End add non-stock playerlist data --
            
            UIList.playerListInfoList[adjustedClientIndex] = playerSlotModel
        end
        
        if not UIList.playerConnectedSubscription then
            UIList.playerConnectedSubscription = UIList:subscribeToModel(Engine.GetModel(controllerModel, "playerConnected"), function(ModelRef)
                local ModelValue = Engine.GetModelValue(ModelRef)
                if ModelValue ~= nil then
                    DataSources.PlayerListZM.updateModelsForClient(controller, UIList, ModelValue)
                end
            end, false)
        end

        if not UIList.playerDisconnectedSubscription then
            UIList.playerDisconnectedSubscription = UIList:subscribeToModel(Engine.GetModel(controllerModel, "playerDisconnected"), function(ModelRef)
                local ModelValue = Engine.GetModelValue(ModelRef)
                if ModelValue ~= nil then
                    DataSources.PlayerListZM.updateModelsForClient(controller, UIList, ModelValue)
                end
            end, false)
        end

        if IsDemoPlaying() and not UIList.updatePlayerListOrderSubscription then
            UIList.updatePlayerListOrderSubscription = UIList:subscribeToModel(Engine.CreateModel(Engine.GetGlobalModel(), "demo.clientNum"), function(ModelRef)
                if Engine.GetModelValue(ModelRef) ~= nil then
                    DataSources.PlayerListZM.updateModelsForClient(controller)
                end
            end, false)
        end

        -- This part sorts the players according to their clientNum
        local tempPlayerListInfoList = {}
        for adjustedClientIndex, playerSlotModel in pairs(UIList.playerListInfoList) do
            local clientNum = Engine.GetModelValue(Engine.GetModel(playerSlotModel, "clientNum"))
            tempPlayerListInfoList[clientNum + 1] = playerSlotModel
        end
        UIList.playerListInfoList = tempPlayerListInfoList
        -- End sorting players
    end,
    updateModelsForClient = function(controller, UIList, ClientIndex)
        local playerSlotModel = DataSources.PlayerListZM.getModelForPlayer(controller, UIList, ClientIndex)
        if playerSlotModel ~= nil and ClientIndex ~= nil then
            local playerListData = Engine.GetPlayerListData(controller, ClientIndex)
            for modelName, modelValue in pairs(DataSources.PlayerListZM.modelLinks) do -- modelName == modelValue
                local playerSlotSubmodel = Engine.GetModel(playerSlotModel, modelValue)
                if playerSlotSubmodel then
                    Engine.SetModelValue(playerSlotSubmodel, playerListData[modelName])
                end
            end
        end

        UIList:updateDataSource()
    end,
    getCount = function(UIList)
        local count = 0
        for index, playerSlotModel in pairs(UIList.playerListInfoList) do
            local playerConnected = Engine.GetModel(playerSlotModel, "playerConnected")
            if playerConnected and Engine.GetModelValue(playerConnected) ~= 0 then
                count = count + 1
            end
        end

        return count
    end,
    getItem = function(controller, UIList, ItemIndex)
        return UIList.playerListInfoList[ItemIndex]
    end,
    getModelForPlayer = function(controller, UIList, ClientIndex)
        for clientIndex = 1, Dvar.com_maxclients:get() do
            local playerSlotModel = UIList.playerListInfoList[clientIndex]
            local clientNumModel = Engine.GetModel(playerSlotModel, "clientNum")
            if clientNumModel and clientNumModel == ClientIndex then
                return playerSlotModel
            end
        end

        DebugPrint("WARNING: returning invalid playerListInfoList row")
        return UIList.playerListInfoList[1]
    end,
    getWidgetTypeForItem = function(UIList, ItemModel, RowIndex, ColumnIndex)
        if ItemModel then
            local clientNum = Engine.GetModelValue(Engine.GetModel(ItemModel, "clientNum"))
            if clientNum == Engine.GetClientNum(UIList.controller) then
                return CoD.T5SelfScoreWidget
            else
                return CoD.T5ClientScoreWidget
            end
        end
        
        return nil
    end
}

DataSources.ZMPlayerList = {
    getModel = function(controller)
        return Engine.GetModel(Engine.GetModelForController(controller), "PlayerList")
    end
}

local function PreLoadFunc( self, controller )
    for index = 0, 3 do
        local clientModel = Engine.CreateModel( DataSources.ZMPlayerList.getModel( controller ), index )
        Engine.SetModelValue( Engine.CreateModel( clientModel, "zombieInventoryIcon" ), "blacktransparent" )
        Engine.SetModelValue( Engine.CreateModel( clientModel, "zombieWearableIcon" ), "blacktransparent" )
    end
end

CoD.T5ScoreWidget = InheritFrom(LUI.UIElement)
CoD.T5ScoreWidget.RowWidth = 150
CoD.T5ScoreWidget.ClientRowWidth = 20
CoD.T5ScoreWidget.RowHeight = 30
CoD.T5ScoreWidget.Bottom = -90
CoD.T5ScoreWidget.StartingPoints = 500
CoD.T5ScoreWidget.ScoreBottomOffset = 1.5
CoD.T5ScoreWidget.Spacing = 1.5

CoD.T5ScoreWidget.T7GlowStyle = false

CoD.T5ScoreWidget.PositiveColor = { r = 0.9, g = 0.9, b = 0.0 }
CoD.T5ScoreWidget.NegativeColor = { r = 0.21, g = 0.0, b = 0.0 }

function CoD.T5ScoreWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass(CoD.T5ScoreWidget)
    self.id = "T5ScoreWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

	local ScaleContainer = CoD.SplitscreenScaler.new( nil, 1.2 )
	ScaleContainer:setLeftRight( false, true, 0, 0 )
	ScaleContainer:setTopBottom( false, true, 0, 0 )

	self:addElement(ScaleContainer)
    self.ScaleContainer = ScaleContainer

    local ZMPlayerList = LUI.UIList.new( menu, controller, 0, 0, nil, false, false, 0, 0, false, false )
    ZMPlayerList:makeFocusable()
    ZMPlayerList:setLeftRight( false, true, -150.0, 0.0 )
    ZMPlayerList:setTopBottom( false, true, ( ( ( CoD.T5ScoreWidget.Bottom - ( CoD.T5ScoreWidget.RowHeight * CoD.T5ScoreWidget.ScoreBottomOffset ) ) - CoD.T5ScoreWidget.RowHeight ) - 5 ), ( ( CoD.T5ScoreWidget.Bottom - ( CoD.T5ScoreWidget.RowHeight * CoD.T5ScoreWidget.ScoreBottomOffset ) ) + 5 ) )
    ZMPlayerList:setDataSource( "PlayerListZM" )
    ZMPlayerList:setWidgetType( CoD.T5SelfScoreWidget )
    ZMPlayerList:setVerticalCount( 4 )
    ZMPlayerList:setSpacing( CoD.T5ScoreWidget.Spacing )

    self.ScaleContainer:addElement( ZMPlayerList )
    self.ZMPlayerList = ZMPlayerList

    self.ZMPlayerList:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "scoreboard.team1.count" ), function( ModelRef )
        local teamCount = Engine.GetModelValue( ModelRef )
        if teamCount then
            self.ZMPlayerList:setVerticalCount( teamCount )
        end
    end )

    --[[local SelfScoreDummy = LUI.UIList.new(menu, controller, 2, 0, nil, false, false, 0, 0, false, false)
    SelfScoreDummy:setWidgetType(CoD.T5SelfScoreWidget)
    SelfScoreDummy:setDataSource("PlayerListZM")
    SelfScoreDummy:setAlpha(0)

    self.ScaleContainer:addElement(SelfScoreDummy)
    self.SelfScoreDummy = SelfScoreDummy


    local SelfScore = CoD.T5SelfScoreWidget.new(menu, controller)
    SelfScore:setLeftRight(false, true, ((-CoD.T5ScoreWidget.RowWidth) - 8), 0)
    SelfScore:setTopBottom(false, true, (((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 1)) - CoD.T5ScoreWidget.RowHeight) - 5), ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 1)) + 5))

    SelfScore:subscribeToGlobalModel(controller, "ZMPlayerList", "0", function(ModelRef)
        SelfScore:setModel(ModelRef, controller)
    end)

    self.ScaleContainer:addElement(SelfScore)
    self.SelfScore = SelfScore


    local Client2Score = CoD.T5ClientScoreWidget.new(menu, controller)
    Client2Score:setLeftRight(false, true, -CoD.T5ScoreWidget.RowWidth, -CoD.T5ScoreWidget.ClientRowWidth)
    Client2Score:setTopBottom(false, true, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 2)) - CoD.T5ScoreWidget.RowHeight) + 3, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 2)) - 3))

    Client2Score:subscribeToGlobalModel(controller, "ZMPlayerList", "1", function(ModelRef)
        Client2Score:setModel(ModelRef, controller)
    end)

    self.ScaleContainer:addElement(Client2Score)
    self.Client2Score = Client2Score


    local Client3Score = CoD.T5ClientScoreWidget.new(menu, controller)
    Client3Score:setLeftRight(false, true, -CoD.T5ScoreWidget.RowWidth, -CoD.T5ScoreWidget.ClientRowWidth)
    Client3Score:setTopBottom(false, true, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 3)) - CoD.T5ScoreWidget.RowHeight) + 3, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 3)) - 3))

    Client3Score:subscribeToGlobalModel(controller, "ZMPlayerList", "2", function(ModelRef)
        Client3Score:setModel(ModelRef, controller)
    end)

    self.ScaleContainer:addElement(Client3Score)
    self.Client3Score = Client3Score


    local Client4Score = CoD.T5ClientScoreWidget.new(menu, controller)
    Client4Score:setLeftRight(false, true, -CoD.T5ScoreWidget.RowWidth, -CoD.T5ScoreWidget.ClientRowWidth)
    Client4Score:setTopBottom(false, true, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 4)) - CoD.T5ScoreWidget.RowHeight) + 3, ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 4)) - 3))

    Client4Score:subscribeToGlobalModel(controller, "ZMPlayerList", "3", function(ModelRef)
        Client4Score:setModel(ModelRef, controller)
    end)

    self.ScaleContainer:addElement(Client4Score)
    self.Client4Score = Client4Score]]

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(1)
                self:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
                self:setAlpha(1)
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter(1)
                self:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
                self:setAlpha(0)
            end
        }
    }
    
    self.StateTable = {
        {
            stateName = "Hidden",
            condition = function(menu, controller, arg2)
                return Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_SCOPED) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) or
                       Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE)
            end
        }
    }

    self:mergeStateConditions(self.StateTable)
    
    SubscribeToModelAndUpdateState(controller, menu, self, "hudItems.playerSpawned")
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE)
    SubscribeToModelAndUpdateState(controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
        --[[element.SelfScore:close()
        element.SelfScoreDummy:close()
        element.Client2Score:close()
        element.Client3Score:close()
        element.Client4Score:close()]]
        element.ZMPlayerList:close()
        element.ScaleContainer:close()
    end)

    if PreLoadFunc then
        PreLoadFunc( self, controller, menu )
    end

    return self
end

CoD.T5ScoreWidget.GetScoreBarColor = function ( index )
    if CoD.isZombie == true then
        local playerColorIndex = ( index ) % 4 + 1
        return CoD.Zombie.PlayerColors[playerColorIndex].r, CoD.Zombie.PlayerColors[playerColorIndex].g, CoD.Zombie.PlayerColors[playerColorIndex].b
    else
        return CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b
    end
end

CoD.T5ScoreWidget.UseT7GlowStyle = function ()
    if CoD.T5ScoreWidget.T7GlowStyle then
        return CoD.T5ScoreWidget.T7GlowStyle
    end

    return false
end