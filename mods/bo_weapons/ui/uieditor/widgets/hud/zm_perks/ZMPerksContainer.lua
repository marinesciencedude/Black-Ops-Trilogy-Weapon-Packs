require( "ui.uieditor.widgets.HUD.ZM_Perks.PerkListItem" )

local perkListBase = {
	additional_primary_weapon = "zod_specialty_mule",
	dead_shot = "zod_specialty_deadshot",
	dive_to_nuke = "specialty_divetonuke_zombies",
	doubletap2 = "zod_specialty_doubletap",
	juggernaut = "zod_specialty_jugg",
	marathon = "zod_specialty_staminup",
	quick_revive = "zod_specialty_quickrevive",
	sleight_of_hand = "zod_specialty_speedcola",
	tombstone = "specialty_tombstone_zombies",
	widows_wine = "zod_specialty_widows",
	phdflopper = "zod_specialty_flopper",
	doubletap = "specialty_giant_doubletap1_zombies",
	
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

local function CheckExistantCF(PerkList, perkListBaseCF)
	if PerkList ~= nil then
		for index=1.000000, #PerkList, 1.000000 do
			if PerkList[index].properties.key == perkListBaseCF then
				return index
			end
		end
		return nil
	end
end

local function GetPerkSlotByCFAndValue(PerkList, perkListBaseCF, ModelValue)
	if PerkList ~= nil then
		for index=1.000000, #PerkList, 1.000000 do
			if PerkList[index].properties.key == perkListBaseCF then
				if PerkList[index].models.status ~= ModelValue then
					return index
				end
			end
		end
		return -1.000000
	end
end

local function InitPerks(PerkList, InstanceRef)
	if not PerkList.perksList then
		PerkList.perksList = {}
	end
	local PerksModelBase = Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.perks")
	local k, v, p = pairs(perkListBase)
	for PerkKey,value in k, v, p do
		local ModelValue = Engine.GetModelValue(Engine.GetModel(PerksModelBase, PerkKey))
		if ModelValue ~= nil then
			if 0.000000 < ModelValue then
				local IsPerkExist1 = CheckExistantCF(PerkList.perksList, PerkKey)
                local PerkSlot = GetPerkSlotByCFAndValue(PerkList.perksList, PerkKey, ModelValue)
				if not IsPerkExist1 then
					local props = {models = {image = value, status = ModelValue, newPerk = false},properties = {key = PerkKey} }
					table.insert(PerkList.perksList, props)
                elseif 0.000000 < PerkSlot then
						PerkList.perksList[PerkSlot].models.status = ModelValue
						local ZMPerksUIModel = Engine.GetModel(Engine.GetModelForController(InstanceRef), "ZMPerks")
						local PerkKey = tostring(PerkSlot)
						local PerkStatutModel = Engine.GetModel(ZMPerksUIModel, (PerkKey .. ".status"))
                        Engine.SetModelValue(PerkStatutModel, ModelValue)
                end
			else
			    local IsPerkExist2 = CheckExistantCF(PerkList.perksList, PerkKey)
				if IsPerkExist2 then
					table.remove(PerkList.perksList, IsPerkExist2)
				end
			end
		end
	end
	if PerkList then
		for index1=1.000000, #PerkList.perksList, 1.000000 do
			local isNewPerk = (index1 == #PerkList.perksList)
			PerkList.perksList[index1].models.newPerk = isNewPerk
		end
		if PerkList then
            return true
		end
	else
		for index2=1.000000, #PerkList.perksList, 1.000000 do
			local PerkUIModelAtCurrentSlot = Engine.GetModel(PerksModelBase, PerkList.perksList[index2].properties.key)
			Engine.SetModelValue(PerkUIModelAtCurrentSlot, PerkList.perksList[index2].models.status)
		end
		return false
	end
end

local function DataSourcePerkInit(InstanceRef, PerkList)
	InitPerks(PerkList, InstanceRef)
	return PerkList.perksList
end

local function PreLoadCustom(HudRef, InstanceRef)
	for index,value in pairs(perkListBase) do
		local perkUiModel = Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(InstanceRef), "hudItems.perks"), index)
	    local function InitsPerks(ModelRef)
		    local PerksExists = InitPerks(HudRef.PerkList, InstanceRef)
            if PerksExists then
                HudRef.PerkList:updateDataSource()

		    end
	    end

		HudRef:subscribeToModel(perkUiModel, InitsPerks, false)
	end
end

CoD.ZMPerksContainer = InheritFrom(LUI.UIElement)

function CoD.ZMPerksContainer.new(HudRef, InstanceRef)
	local Elem = LUI.UIElement.new()

	Elem:setUseStencil(false)
	Elem:setClass(CoD.ZMPerksContainer)
	Elem.id = "ZMPerksContainer"
	Elem.soundSet = "default"
	Elem:setLeftRight(true, false, 0.000000, 151.000000)
	Elem:setTopBottom(true, false, 0.000000, 36.000000)
    Elem.anyChildUsesUpdateState = true
    
	if PreLoadCustom then
        PreLoadCustom(Elem, InstanceRef)
	end

	local perkList = LUI.UIList.new(HudRef, InstanceRef, 2.000000, 0.000000, nil, false, false, 0.000000, 0.000000, false, false)
	perkList:makeFocusable()
	perkList:setLeftRight(true, false, 0, 378) -- 378 pixels apart (for center, do -189,189).
	perkList:setTopBottom(false, true, -36.000000, 0.000000)
	perkList:setWidgetType(CoD.PerkListItem)

	-- perkListEDIT
	perkList:setHorizontalCount(33)	 			-- How many perks you want in a single row. Will start a new column afer obtaining "x" perks if setVerticalCount > 1; if setVerticalCount < or = 1, anything after "x" wont show on screen.
	perkList:setVerticalCount(1) 				-- How many columns you want. Default is 1.

    perkList:setXRot(0)
	perkList:setDataSource("ZMPerks")
	Elem:addElement(perkList)
    Elem.PerkList = perkList

	local function DefaultClipFn()
		Elem:setupElementClipCounter(1.000000)
		perkList:completeAnimation()
		Elem.PerkList:setAlpha(1.000000)
		Elem.clipFinished(perkList, {})
	end

	local function DefaultClipHideFn()
		Elem:setupElementClipCounter(1.000000)
		perkList:completeAnimation()
		Elem.PerkList:setAlpha(0.000000)
		Elem.clipFinished(perkList, {})
	end

	Elem.clipsPerState = {DefaultState = {DefaultClip = DefaultClipFn}, Hidden = {DefaultClip = DefaultClipHideFn}}

    local function HiddenCondition(arg0, arg2, arg3)
        if IsModelValueTrue(InstanceRef, "hudItems.playerSpawned") and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) and not
        Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) then
            return false
        else
            return true
        end
    end
    
	Elem:mergeStateConditions({{stateName = "Hidden", condition = HiddenCondition}})
    local function PlayerSpawnCallback(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "hudItems.playerSpawned"})
    end
    
    local function MergeBitVisible(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), 
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
    end
    
    local function MergeBitWeapon(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE})
    end
    
    local function MergeBitHardcore(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
    end
    
    local function MergeBitEndGame(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED})
    end
    
    local function MergeBitDemoMovie(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM})
    end
    
    local function MergeBitDemoHidden(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN})
    end
    
    local function MergeBitInKillcam(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM})
    end
    
    local function MergeBitFlash(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
    end
    
    local function MergeBitActive(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
    end
    
    local function MergeBitScoped(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED})
    end
    
    local function MergeBitVehicle(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE})
    end
    
    local function MergeBitMissile(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
    end
    
    local function MergeBitBoardOpen(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
    end
    
    local function MergeBitStaticKill(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC})
    end
    
    local function MergeBitEmpActive(ModelRef)
        HudRef:updateElementState(Elem, {name = "model_validation",
            menu = HudRef, modelValue = Engine.GetModelValue(ModelRef),
            modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE})
    end
    
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.playerSpawned"), PlayerSpawnCallback)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), MergeBitVisible)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE), MergeBitWeapon)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), MergeBitHardcore)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), MergeBitEndGame)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), MergeBitDemoMovie)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), MergeBitDemoHidden)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM), MergeBitInKillcam)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), MergeBitFlash)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), MergeBitActive)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), MergeBitScoped)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), MergeBitVehicle)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), MergeBitMissile)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), MergeBitBoardOpen)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), MergeBitStaticKill)
    Elem:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), MergeBitEmpActive)
    
	perkList.id = "PerkList"
	local function CloseEvent(SenderObj)
		SenderObj.PerkList:close()
	end

	LUI.OverrideFunction_CallOriginalSecond(Elem, "close", CloseEvent)
	if PostLoadFunc then
		PostLoadFunc(Elem, InstanceRef, HudRef)
	end
	return Elem
end

DataSources.ZMPerks = DataSourceHelpers.ListSetup("ZMPerks", DataSourcePerkInit, true)
