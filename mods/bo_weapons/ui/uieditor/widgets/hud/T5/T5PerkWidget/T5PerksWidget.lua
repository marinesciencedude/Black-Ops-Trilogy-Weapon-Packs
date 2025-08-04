require("UI.SubscriptionUtils")
require("UI.UIEditor.Widgets.HUD.T5.T5PerkWidget.T5PerkItemWidget")

CoD.T5PerksWidget = InheritFrom(LUI.UIElement)
--this number is correct
CoD.T5PerksWidget.TopStart = -140
CoD.T5PerksWidget.Spacing = 7.5

local PerksTable = {
    additional_primary_weapon       = "t5specialty_additionalprimaryweapon_zombies",
    dead_shot                       = "t5specialty_ads_zombies",
    dive_to_nuke                    = "t5specialty_divetonuke_zombies",
    phdflopper                    = "t5specialty_divetonuke_zombies",
    doubletap                       = "t5specialty_doubletap_zombies",
	doubletap2 = "classic_clean_doubletap_alt",
    juggernaut                      = "t5specialty_juggernaut_zombies",
    marathon                        = "t5specialty_marathon_zombies",
    quick_revive                    = "t5specialty_quickrevive_zombies",
    sleight_of_hand                 = "t5specialty_fastreload_zombies",
	widows_wine = "classic_clean_widows",
	electric_cherry = "classic_clean_cherry",
	
	phdflopper_bo = "classic_clean_flopper",
	additional_primary_weapon_bo = "classic_clean_mulekick",
	quick_revive_bo = "classic_clean_revive",
	juggernaut_bo = "classic_clean_juggernog",
	sleight_of_hand_bo = "classic_clean_speed",
	marathon_bo = "classic_clean_staminup",
	widows_wine_bo = "classic_clean_widows",
	electric_cherry_bo = "classic_clean_cherry",
	dead_shot_bo = "classic_clean_deadshot",
	doubletap2_bo = "classic_clean_doubletap_alt",
	doubletap_bo = "classic_clean_doubletap",
	
	phdflopper_recolour = "madkixs_specialty_phdflopper",
	additional_primary_weapon_recolour = "madkixs_specialty_mulekick",
	quick_revive_recolour = "madkixs_specialty_quickrevive",
	juggernaut_recolour = "madkixs_specialty_juggernog",
	sleight_of_hand_recolour = "madkixs_specialty_speedcola",
	marathon_recolour = "madkixs_specialty_staminup",
	widows_wine_recolour = "madkixs_specialty_widowswine",
	electric_cherry_recolour = "madkixs_specialty_electriccherry",
	dead_shot_recolour = "madkixs_specialty_deadshot",
	doubletap2_recolour = "madkixs_specialty_doubletap2",
	doubletap_recolour = "madkixs_specialty_doubletap"
}

local PerkOverlaysTable = {}

-- Widget is whatever is using the datasource, in this case it's the perksContainer UIList.
local PerksList = {}
local function GetPerkIndexFromModelName(perkModelName)
    for index=1, #PerksList do
        if PerksList[index] then
            if PerksList[index].properties.key == perkModelName then
                return index
            end
        end
    end

    return nil
end
local function UpdatePerksTable(controller, Widget)
    local PerkModel = Engine.GetModel(Engine.GetModelForController(controller), "hudItems.perks")

    for perkModelName,perkImageName in pairs(PerksTable) do
        local perkModel = Engine.GetModel(PerkModel, perkModelName)
        local perkState = Engine.GetModelValue(perkModel)
        local perkIndex = GetPerkIndexFromModelName(perkModelName)

        if perkIndex then
            -- Perk exists
            if perkIndex > 0 then
            -- Index is valid
                if perkState == 0 then
                    table.remove(PerksList, perkIndex)
                elseif perkState == 1 then
                    -- Icon widget exists, make sure it's not labeled as a new perk
                    PerksList[perkIndex].models.newPerk = false
                    PerksList[perkIndex].models.status = perkState
                
                elseif perkState == 2 then
                    -- Icon widget exists, make sure it's not labeled as a new perk
                    PerksList[perkIndex].models.newPerk = false
                    PerksList[perkIndex].models.status = perkState
                end
            end
        else
            -- Perk didn't exist
                if perkState == 1 then
                -- Create perk icon
                table.insert(PerksList, {
                    models = {
                        image = perkImageName,
                        status = perkState,
                        newPerk = true,
                    },
                    properties = {
                        key = perkModelName
                    }
                })
            end
        end
    end
end

DataSources.PerksDataSource = DataSourceHelpers.ListSetup("PerksDataSource", function(controller, PerkListWidget)
    UpdatePerksTable(controller, PerkListWidget)
    return PerksList
end, true)

function CoD.T5PerksWidget.new(menu, controller)
    local self = LUI.UIElement.new()
    self:setClass(CoD.T5PerksWidget)
    self.id = "T5PerksWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = false

    self.ScaleContainer = CoD.SplitscreenScaler.new(nil, 1.2)
    self.ScaleContainer:setLeftRight(true, false, 0, 0)
    self.ScaleContainer:setTopBottom(false, true, 0, 0)
    self:addElement(self.ScaleContainer)

    -- the perk icons are spaced 30 units away from each other
    -- divide by 2 for correct distance
    self.perksContainer = LUI.UIList.new(menu, controller, CoD.T5PerksWidget.Spacing, 0, nil, false, false, 0, 0, false, false)
    self.perksContainer:makeFocusable()
    self.perksContainer:setLeftRight( true, false, 0, 36 )
    self.perksContainer:setTopBottom( false, true, CoD.T5PerksWidget.TopStart, CoD.T5PerksWidget.TopStart + 36 )
    self.perksContainer:setWidgetType(CoD.T5PerkItemWidget)
    self.perksContainer:setHorizontalCount( 8 ) -- keep bumping this number up
    self.perksContainer:setDataSource("PerksDataSource")
    self.ScaleContainer:addElement(self.perksContainer)

    local PerkModel = Engine.GetModel(Engine.GetModelForController(controller), "hudItems.perks")
    for perkModelName,perkImageName in pairs(PerksTable) do
        -- Update when gained / lost perk
        self:subscribeToModel(Engine.GetModel(PerkModel, perkModelName), function(ModelRef)
            self.perksContainer:updateDataSource()
        end, false)
    end

    self.StateTable = {
        {
            stateName = "Hidden",
            condition = function(menu, element, event)
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

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(1)

                self.ScaleContainer:completeAnimation()
                self.ScaleContainer:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
                self.ScaleContainer:setAlpha(1)
                self.ScaleContainer:registerEventHandler("transition_complete_keyframe", function(element, event)
                    self.clipFinished(element, event)
                end)
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter(1)

                self.ScaleContainer:completeAnimation()
                self.ScaleContainer:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
                self.ScaleContainer:setAlpha(0)
                self.ScaleContainer:registerEventHandler("transition_complete_keyframe", function(element, event)
                    self.clipFinished(element, event)
                end)
            end
        }
    }
    
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
    
    return self
end