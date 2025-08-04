--[[
    Decompiled with CoDHVKDecompiler by JariK
    Rebuilt by Kingslayer Kyle
]]
CoD.PowerUps = {}
CoD.PowerUps.IconSize = 48
CoD.PowerUps.UpgradeIconSize = 36
CoD.PowerUps.Spacing = 8
CoD.PowerUps.STATE_OFF = 0
CoD.PowerUps.STATE_ON = 1
CoD.PowerUps.STATE_FLASHING_OFF = 2
CoD.PowerUps.STATE_FLASHING_ON = 3
CoD.PowerUps.FLASHING_STAGE_DURATION = 1
CoD.PowerUps.MOVING_DURATION = 1

CoD.PowerUps.UpGradeIconColorRed = {
	r = 1,
	g = 0,
	b = 0
}

CoD.PowerUps.ClientFieldNames = {
    {
        clientFieldName = "powerup_instant_kill",
        material = RegisterMaterial("t5specialty_instakill_zombies")
    },
    {
        clientFieldName = "powerup_double_points",
        material = RegisterMaterial("t5specialty_2x_zombies"),
        z_material = RegisterMaterial("t5specialty_2x_zombies_blue")
    },
    {
        clientFieldName = "powerup_fire_sale",
        material = RegisterMaterial("t5specialty_firesale_zombies")
    },
    {
        clientFieldName = "powerup_bon_fire",
        material = RegisterMaterial("t5specialty_bonfire_zombies")
    },
    {
        clientFieldName = "powerup_mini_gun",
        material = RegisterMaterial("t5specialty_deathmachine_zombies")
    },
    {
        clientFieldName = "powerup_zombie_blood",
        material = RegisterMaterial("t5specialty_zomblood_zombies")
    }
}

CoD.PowerUps.UpgradeClientFieldNames = {
    {
        clientFieldName = "powerup_instant_kill_ug",
        material = RegisterMaterial("t5specialty_instakill_zombies"),
        color = CoD.PowerUps.UpGradeIconColorRed
    }
}

LUI.createMenu.PowerUpsArea = function (InstanceRef)
	local HudRef = CoD.Menu.NewSafeAreaFromState("PowerUpsArea", InstanceRef)
	HudRef:setOwner(InstanceRef)
	HudRef.scaleContainer = CoD.SplitscreenScaler.new(nil, 1.2)
	HudRef.scaleContainer:setLeftRight(false, false, 0, 0)
	HudRef.scaleContainer:setTopBottom(false, true, 0, 0)
	HudRef:addElement(HudRef.scaleContainer)
	HudRef.powerUps = {}
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, false, -CoD.PowerUps.IconSize * 0.5, CoD.PowerUps.IconSize * 0.5)
		Widget:setTopBottom(false, true, -CoD.PowerUps.IconSize + CoD.PowerUps.UpgradeIconSize + 10 - 25, -25)
		Widget:registerEventHandler("transition_complete_off_fade_out", CoD.PowerUps.PowerUpIcon_UpdatePosition)
		
		Widget.powerUpIcon = LUI.UIImage.new()
		Widget.powerUpIcon:setLeftRight(true, true, 0, 0)
		Widget.powerUpIcon:setTopBottom(false, true, -CoD.PowerUps.IconSize, 0)
		Widget.powerUpIcon:setAlpha(0)

		Widget:addElement(Widget.powerUpIcon)
		
		Widget.upgradePowerUpIcon = LUI.UIImage.new()
		Widget.upgradePowerUpIcon:setLeftRight(false, false, -CoD.PowerUps.UpgradeIconSize / 2, CoD.PowerUps.UpgradeIconSize / 2)
		Widget.upgradePowerUpIcon:setTopBottom(true, false, 0, CoD.PowerUps.UpgradeIconSize)
		Widget.upgradePowerUpIcon:setAlpha(0)

		Widget:addElement(Widget.upgradePowerUpIcon)
		
		Widget.powerupId = nil

		HudRef.scaleContainer:addElement(Widget)

		HudRef.powerUps[index] = Widget

		HudRef:registerEventHandler(CoD.PowerUps.ClientFieldNames[index].clientFieldName, CoD.PowerUps.Update)
		HudRef:registerEventHandler(CoD.PowerUps.ClientFieldNames[index].clientFieldName .. "_ug", CoD.PowerUps.UpgradeUpdate)
	end

	HudRef.activePowerUpCount = 0

    local UpdateVisibility = function(ModelRef)
        CoD.PowerUps.UpdateVisibility(HudRef, InstanceRef)
    end

	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), UpdateVisibility)
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), UpdateVisibility)

	HudRef:registerEventHandler("powerups_update_position", CoD.PowerUps.UpdatePosition)
    
	HudRef.visible = true

	return HudRef
end

CoD.PowerUps.UpdateVisibility = function (HudRef, InstanceRef)
	if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and
    (not CoD.IsShoutcaster(InstanceRef) or CoD.ShoutcasterProfileVarBool(InstanceRef, "shoutcaster_teamscore")) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not
    Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED) then
		if not HudRef.visible then
			HudRef:setAlpha(1)
			HudRef.visible = true
		end
	elseif HudRef.visible then
		HudRef:setAlpha(0)
		HudRef.visible = nil
	end
end

CoD.PowerUps.Update = function (Sender, Event)
	CoD.PowerUps.UpdateState(Sender, Event)
	CoD.PowerUps.UpdatePosition(Sender, Event)
end

CoD.PowerUps.UpdateState = function (Sender, Event)
	local powerUp = nil
	local index = CoD.PowerUps.GetExistingPowerUpIndex(Sender, Event.name)
	if index ~= nil then
		powerUp = Sender.powerUps[index]
		if Event.newValue == CoD.PowerUps.STATE_ON then
			powerUp.powerUpId = Event.name
			powerUp.powerUpIcon:setImage(CoD.PowerUps.GetMaterial(Sender, Event.controller, Event.name))
			powerUp.powerUpIcon:setAlpha(1)
		elseif Event.newValue == CoD.PowerUps.STATE_OFF then
			powerUp.powerUpIcon:beginAnimation("off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp.powerUpIcon:setAlpha(0)
			powerUp.upgradePowerUpIcon:beginAnimation("off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp.upgradePowerUpIcon:setAlpha(0)
			powerUp.powerUpId = nil
			Sender.activePowerUpCount = Sender.activePowerUpCount - 1
		elseif Event.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			powerUp.powerUpIcon:beginAnimation("fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp.powerUpIcon:setAlpha(0)
		elseif Event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			powerUp.powerUpIcon:beginAnimation("fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp.powerUpIcon:setAlpha(1)
		end
	elseif Event.newValue == CoD.PowerUps.STATE_ON or Event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
		local index = CoD.PowerUps.GetFirstAvailablePowerUpIndex(Sender)
		if index ~= nil then
			powerUp = Sender.powerUps[index]
			powerUp.powerUpId = Event.name
			powerUp.powerUpIcon:setImage(CoD.PowerUps.GetMaterial(Sender, Event.controller, Event.name))
			powerUp.powerUpIcon:setAlpha(1)
			Sender.activePowerUpCount = Sender.activePowerUpCount + 1
		end
	end
end

CoD.PowerUps.UpgradeUpdate = function (Sender, Event)
	CoD.PowerUps.UpgradeUpdateState(Sender, Event)
end

CoD.PowerUps.UpgradeUpdateState = function (Sender, Event)
	local powerUp = nil
	local index = CoD.PowerUps.GetExistingPowerUpIndex(Sender, string.sub(Event.name, 0, -4))
	if index ~= nil then
		powerUp = Sender.powerUps[index].upgradePowerUpIcon
		if Event.newValue == CoD.PowerUps.STATE_ON then
			powerUp:setImage(CoD.PowerUps.GetUpgradeMaterial(Sender, Event.name))
			powerUp:setAlpha(1)
			CoD.PowerUps.SetUpgradeColor(powerUp, Event.name)
		elseif Event.newValue == CoD.PowerUps.STATE_OFF then
			powerUp:beginAnimation("off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp:setAlpha(0)
		elseif Event.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			powerUp:beginAnimation("fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp:setAlpha(0)
		elseif Event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			powerUp:beginAnimation("fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION)
			powerUp:setAlpha(1)
		end
	end
end

CoD.PowerUps.GetMaterial = function (Sender, InstanceRef, clientFieldName)
	local material = nil
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if CoD.PowerUps.ClientFieldNames[index].clientFieldName == clientFieldName then
			material = CoD.PowerUps.ClientFieldNames[index].material
			break
		end
	end
	return material
end

CoD.PowerUps.GetUpgradeMaterial = function (Sender, clientFieldName)
	local material = nil
	for index = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[index].clientFieldName == clientFieldName then
			material = CoD.PowerUps.UpgradeClientFieldNames[index].material
			break
		end
	end
	return material
end

CoD.PowerUps.SetUpgradeColor = function (Sender, clientFieldName)
	local color = nil
	for index = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[index].clientFieldName == clientFieldName then
			if CoD.PowerUps.UpgradeClientFieldNames[index].color then
				Sender:setRGB(CoD.PowerUps.UpgradeClientFieldNames[index].color.r, CoD.PowerUps.UpgradeClientFieldNames[index].color.g, CoD.PowerUps.UpgradeClientFieldNames[index].color.b)
				break
			end
		end
	end
end

CoD.PowerUps.GetExistingPowerUpIndex = function (Sender, powerUpId)
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if Sender.powerUps[index].powerUpId == powerUpId then
			return index
		end
	end
	return nil
end

CoD.PowerUps.GetFirstAvailablePowerUpIndex = function (Sender)
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if not Sender.powerUps[index].powerUpId then
			return index
		end
	end
	return nil
end

CoD.PowerUps.PowerUpIcon_UpdatePosition = function (Sender, Event)
	if Event.interrupted ~= true then
		Sender:dispatchEventToParent({
			name = "powerups_update_position"
		})
	end
end

CoD.PowerUps.UpdatePosition = function (Sender, Event)
	local powerUp = nil
	local LeftAnchor = 0
	local RightAnchor = 0
	local AnimationOffset = nil
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		powerUp = Sender.powerUps[index]
		if powerUp.powerUpId ~= nil then
			if not AnimationOffset then
				LeftAnchor = -(CoD.PowerUps.IconSize * 0.5 * Sender.activePowerUpCount + CoD.PowerUps.Spacing * 0.5 * (Sender.activePowerUpCount - 1))
			else
				LeftAnchor = AnimationOffset + CoD.PowerUps.IconSize + CoD.PowerUps.Spacing
			end
			RightAnchor = LeftAnchor + CoD.PowerUps.IconSize
			powerUp:beginAnimation("move", CoD.PowerUps.MOVING_DURATION)
			powerUp:setLeftRight(false, false, LeftAnchor, RightAnchor)
			AnimationOffset = LeftAnchor
		end
	end
end