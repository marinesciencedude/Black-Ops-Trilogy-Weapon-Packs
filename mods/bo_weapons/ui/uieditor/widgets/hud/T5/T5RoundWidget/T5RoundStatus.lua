require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.RoundStatus = {}
CoD.RoundStatus.FactionIconLeftOffset = 0
CoD.RoundStatus.FactionIconSize = 96
CoD.RoundStatus.RoundIconLeftOffset = CoD.RoundStatus.FactionIconSize + 0
CoD.RoundStatus.LeftOffset = 0
CoD.RoundStatus.ChalkTop = -96
CoD.RoundStatus.ChalkSize = 96
CoD.RoundStatus.SpecialRoundIconSize = 85
CoD.RoundStatus.RoundCenterHeight = 80
CoD.RoundStatus.Chalks = {}
CoD.RoundStatus.FirstRoundDuration = 1000
CoD.RoundStatus.FirstRoundIdleDuration = 3000
CoD.RoundStatus.FirstRoundFallDuration = 2000
CoD.RoundStatus.RoundPulseDuration = 500
CoD.RoundStatus.RoundPulseTimes = 8
CoD.RoundStatus.RoundPulseTimesDelta = 5
CoD.RoundStatus.RoundPulseTimesMin = 2
CoD.RoundStatus.RoundMax = 100
CoD.RoundStatus.ChalkFontName = "Morris"

CoD.RoundStatus.IsVisible = function(InstanceRef)
    if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) then
        if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_EMP_ACTIVE) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_VEHICLE) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_SCOPED) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) or
           Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
            return false
        else
            return true
        end
    end

    return not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED)
end

CoD.RoundStatus.UpdateVisibility = function(HudRef, InstanceRef)
    if CoD.RoundStatus.IsVisible(InstanceRef) then
        --HudRef:setAlpha(1)
        HudRef:completeAnimation()
        HudRef:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
        HudRef:setAlpha(1)
        HudRef.visible = true
    else
        --HudRef:setAlpha(0)
        HudRef:completeAnimation()
        HudRef:beginAnimation("keyframe", 75, false, false, CoD.TweenType.Linear)
        HudRef:setAlpha(0.001)
        HudRef.visible = false
    end
end

LUI.createMenu.RoundStatus = function(InstanceRef)
    local HudRef = CoD.Menu.NewSafeAreaFromState("RoundStatus", InstanceRef)

    CoD.RoundStatus.DefaultColor = {r = 0.21, g = 0, b = 0}
    CoD.RoundStatus.AlternatePulseColor = {r = 1, g = 1, b = 1}
    CoD.RoundStatus.Chalks[1] = RegisterImage("chalkmarks_1_alpha")
    CoD.RoundStatus.Chalks[2] = RegisterImage("chalkmarks_2_alpha")
    CoD.RoundStatus.Chalks[3] = RegisterImage("chalkmarks_3_alpha")
    CoD.RoundStatus.Chalks[4] = RegisterImage("chalkmarks_4_alpha")
    CoD.RoundStatus.Chalks[5] = RegisterImage("chalkmarks_5_alpha")

    HudRef.gameTypeGroup = Engine.DvarString(nil, "ui_zm_gamemodegroup")
    HudRef.gameType = Engine.GetCurrentGameType()
    HudRef.startRound = Engine.GetGametypeSetting("startRound")

    if HudRef.gameType ~= CoD.Zombie.GAMETYPE_ZGRIEF then
        CoD.RoundStatus.LeftOffset = CoD.RoundStatus.FactionIconLeftOffset
    else
        CoD.RoundStatus.LeftOffset = CoD.RoundStatus.RoundIconLeftOffset
    end

    HudRef.scaleContainer = CoD.SplitscreenScaler.new(nil, 1.2)
    HudRef.scaleContainer:setLeftRight(true, false, 0, 0)
    HudRef.scaleContainer:setTopBottom(false, true, 0, 0)
    HudRef:addElement(HudRef.scaleContainer)

    local safeAreaMinX, safeAreaMinY, safeAreaMaxX, safeAreaMaxY = Engine.GetUserSafeAreaForController(InstanceRef)
    HudRef.safeAreaWidth = (safeAreaMaxX - safeAreaMinX) / HudRef.scaleContainer.scale
    HudRef.safeAreaHeight = (safeAreaMaxY - safeAreaMinY) / HudRef.scaleContainer.scale

    HudRef.chalkCenterTop = -HudRef.safeAreaHeight * 0.5 - CoD.RoundStatus.ChalkSize * 1.5

    HudRef.roundContainer = LUI.UIElement.new()
    HudRef.roundContainer:setLeftRight(true, false, 0, 0)
    HudRef.roundContainer:setTopBottom(false, true, 0, 0)
    HudRef.scaleContainer:addElement(HudRef.roundContainer)

    HudRef.roundIconContainer = LUI.UIElement.new()
    HudRef.roundIconContainer:setLeftRight(true, false, 0, 0)
    HudRef.roundIconContainer:setTopBottom(false, true, 0, 0)
    HudRef.scaleContainer:addElement(HudRef.roundIconContainer)

    local halfSafeAreaWidth = HudRef.safeAreaWidth * 0.5
    HudRef.roundTextCenter = CoD.UIShadowText.new(HudRef, InstanceRef)
    HudRef.roundTextCenter:setLeftRight(true, false, halfSafeAreaWidth * 0.5 + CoD.RoundStatus.ChalkSize * -0.5, halfSafeAreaWidth * 0.5 + CoD.RoundStatus.ChalkSize * 0.5)
    HudRef.roundTextCenter:setTopBottom(false, true, HudRef.chalkCenterTop, HudRef.chalkCenterTop + CoD.RoundStatus.RoundCenterHeight)
    HudRef.roundTextCenter:setTTF( "fonts/helveticaneue.ttf" )
    HudRef.roundTextCenter:setAlignment(LUI.Alignment.Center)
    HudRef.roundTextCenter:setAlpha(0)
    HudRef.roundTextCenter.TextShadow:setRGB( 0.0, 0.0, 0.0 )
    HudRef.roundTextCenter.TextShadow:setShaderVector( 0, 0.21, 0, 0, 0 )
    HudRef.roundTextCenter.TextShadow:setShaderVector( 1, 0, 0, 0, 0 )
    HudRef.roundTextCenter.TextShadow:setShaderVector( 2, 1, 0, 0, 0 )
    HudRef.roundTextCenter:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
    HudRef.roundTextCenter:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish)
    HudRef.roundContainer:addElement(HudRef.roundTextCenter)

    HudRef.roundText = CoD.UIShadowText.new(HudRef, InstanceRef)
    HudRef.roundText:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
    HudRef.roundText:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    HudRef.roundText:setTTF( "fonts/helveticaneue.ttf" )
    HudRef.roundText:setAlpha(0)
    HudRef.roundText.TextShadow:setRGB( 0.0, 0.0, 0.0 )
    HudRef.roundText:setShaderVector( 0, 0.21, 0, 0, 0 )
    HudRef.roundText:setShaderVector( 1, 0, 0, 0, 0 )
    HudRef.roundText:setShaderVector( 2, 1, 0, 0, 0 )
    HudRef.roundText:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
    HudRef.roundText:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundTextIdleFinish)
    HudRef.roundText:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
    HudRef.roundText:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
    HudRef.roundContainer:addElement(HudRef.roundText)

    HudRef.roundChalk1 = LUI.UIImage.new()
    HudRef.roundChalk1:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
    HudRef.roundChalk1:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[1])
    HudRef.roundChalk1:setAlpha(0)
    HudRef.roundChalk1:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
    HudRef.roundChalk1:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish)
    HudRef.roundChalk1:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
    HudRef.roundChalk1:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
    HudRef.roundContainer:addElement(HudRef.roundChalk1)

    HudRef.roundChalk2 = LUI.UIImage.new()
    HudRef.roundChalk2:setLeftRight(true, false, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2)
    HudRef.roundChalk2:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
    HudRef.roundChalk2:setAlpha(0)
    HudRef.roundChalk2:registerEventHandler("transition_complete_first_round", CoD.RoundStatus.ShowFirstRoundFinish)
    HudRef.roundChalk2:registerEventHandler("transition_complete_idle", CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish)
    HudRef.roundChalk2:registerEventHandler("transition_complete_round_switch_show", CoD.RoundStatus.RoundSwitchShowFinish)
    HudRef.roundChalk2:registerEventHandler("transition_complete_round_switch_hide", CoD.RoundStatus.RoundSwitchHideFinish)
    HudRef.roundContainer:addElement(HudRef.roundChalk2)

    HudRef.factionIcon = LUI.UIImage.new()
    HudRef.factionIcon:setLeftRight(true, false, CoD.RoundStatus.FactionIconLeftOffset, CoD.RoundStatus.FactionIconLeftOffset + CoD.RoundStatus.FactionIconSize)
    HudRef.factionIcon:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.FactionIconSize)
    HudRef.factionIcon:setAlpha(0)
    HudRef.scaleContainer:addElement(HudRef.factionIcon)

    HudRef:registerEventHandler("hud_update_rounds_played", CoD.RoundStatus.UpdateRoundsPlayed)
    HudRef:registerEventHandler("hud_update_team_change", CoD.RoundStatus.UpdateTeamChange)

    HudRef.timebombOverride = false;
    if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) then
        HudRef:registerEventHandler("time_bomb_lua_override", CoD.RoundStatus.TimeBombRoundAnimationOverride)
    end

    HudRef.visible = true

    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)
    HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), function(ModelRef)
        CoD.RoundStatus.UpdateVisibility(HudRef, InstanceRef)
    end)

    HudRef.roundContainer:subscribeToGlobalModel(InstanceRef, "GameScore", "roundsPlayed", function(ModelRef)
        local roundNumber = Engine.GetModelValue(ModelRef)
        if roundNumber and type(roundNumber) == "number" then
            roundNumber = roundNumber - 1
            roundNumber = LUI.clamp(roundNumber, 0, 255)
            HudRef:processEvent(
                {
                    name = "hud_update_rounds_played", 
                    controller = InstanceRef, 
                    roundsPlayed = roundNumber, 
                    wasDemoJump = false
                }
            )
        end
    end)

    return HudRef
end

CoD.RoundStatus.UpdateRoundsPlayed = function(HudRef, Event)
    if HudRef.gameType == CoD.Zombie.GAMETYPE_ZCLASSIC or HudRef.gameType == CoD.Zombie.GAMETYPE_ZSTANDARD or HudRef.gameType == CoD.Zombie.GAMETYPE_ZGRIEF then
        CoD.RoundStatus.RoundPulseTimes = math.ceil(CoD.RoundStatus.RoundPulseTimesMin + (1 - math.min(Event.roundsPlayed, CoD.RoundStatus.RoundMax) / CoD.RoundStatus.RoundMax) * CoD.RoundStatus.RoundPulseTimesDelta)
        if HudRef.startRound == Event.roundsPlayed then
            if Event.wasDemoJump == false and HudRef.timebombOverride == false then
                CoD.RoundStatus.ShowFirstRound(HudRef, Event.roundsPlayed)
            else
                HudRef.roundChalk1:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
                HudRef.roundChalk1:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
                local wasDemoJump = Event.wasDemoJump
                if not wasDemoJump then
                    wasDemoJump = HudRef.timebombOverride == true
                end
                CoD.RoundStatus.StartNewRound(HudRef, Event.roundsPlayed, wasDemoJump)
            end
        elseif HudRef.startRound < Event.roundsPlayed then
            HudRef.roundChalk1:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
            HudRef.roundChalk1:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
            HudRef.roundChalk2:setLeftRight(true, false, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2)
            HudRef.roundChalk2:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
            HudRef.roundText:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
            HudRef.roundText:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
            local wasDemoJump = Event.wasDemoJump
            if not wasDemoJump then
                wasDemoJump = HudRef.timebombOverride == true
            end
            CoD.RoundStatus.StartNewRound(HudRef, Event.roundsPlayed, wasDemoJump)
        else
            CoD.RoundStatus.HideAllRoundIcons(HudRef, Event)
        end
    else
        CoD.RoundStatus.HideAllRoundIcons(HudRef, Event)
    end
end

CoD.RoundStatus.ShowFirstRound = function(HudRef, roundsPlayed)
    local zombieRoundText = Engine.Localize("ZOMBIE_ROUND")
    local textX, textY, textWidth, textHeight = GetTextDimensions(zombieRoundText, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)
    local halfSafeAreaWidth = HudRef.safeAreaWidth * 0.5
    local chalkCenterTop = HudRef.chalkCenterTop

    HudRef.roundTextCenter:setLeftRight(false, true, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * -0.5 - textWidth, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * 0.5 + textWidth)
    HudRef.roundTextCenter:setText(zombieRoundText)
    HudRef.roundTextCenter:setAlpha(1)
    HudRef.roundTextCenter:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
    HudRef.roundTextCenter:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
    
    if roundsPlayed <= 5 then
        if roundsPlayed == 1 then
            local f4_local5 = halfSafeAreaWidth - 15
            HudRef.roundChalk1:setLeftRight(true, false, f4_local5, f4_local5 + CoD.RoundStatus.ChalkSize)
        else
            HudRef.roundChalk1:setLeftRight(true, false, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * -0.5, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * 0.5)
        end
        HudRef.roundChalk1:setTopBottom(false, true, chalkCenterTop + CoD.RoundStatus.ChalkSize, chalkCenterTop + CoD.RoundStatus.ChalkSize * 2)
        HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[roundsPlayed])
        HudRef.roundChalk1:setAlpha(1)
        HudRef.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
        HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)

        HudRef.roundChalk2:completeAnimation()
        HudRef.roundChalk2:setAlpha(0)
        HudRef.roundText:completeAnimation()
        HudRef.roundText:setAlpha(0)
    elseif roundsPlayed <= 10 then
        HudRef.roundChalk1:setLeftRight(true, false, halfSafeAreaWidth - CoD.RoundStatus.ChalkSize, halfSafeAreaWidth)
        HudRef.roundChalk1:setTopBottom(false, true, chalkCenterTop + CoD.RoundStatus.ChalkSize, chalkCenterTop + CoD.RoundStatus.ChalkSize * 2)
        HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
        HudRef.roundChalk1:setAlpha(1)
        HudRef.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
        HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)

        HudRef.roundChalk2:setLeftRight(true, false, halfSafeAreaWidth, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize)
        HudRef.roundChalk2:setTopBottom(false, true, chalkCenterTop + CoD.RoundStatus.ChalkSize, chalkCenterTop + CoD.RoundStatus.ChalkSize * 2)
        HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[roundsPlayed - 5])
        HudRef.roundChalk2:setAlpha(1)
        HudRef.roundChalk2:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
        HudRef.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
    else
        textX, textY, textWidth, textHeight = GetTextDimensions(roundsPlayed, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)
        HudRef.roundText:setLeftRight(true, false, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * -0.5 - textWidth, halfSafeAreaWidth + CoD.RoundStatus.ChalkSize * 0.5 + textWidth)
        HudRef.roundText:setTopBottom(false, true, chalkCenterTop + CoD.RoundStatus.ChalkSize, chalkCenterTop + CoD.RoundStatus.ChalkSize * 2)
        HudRef.roundText:setText(roundsPlayed)
        HudRef.roundText:setAlignment(LUI.Alignment.Center)
        HudRef.roundText:setAlpha(1)
        HudRef.roundText:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
        HudRef.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
    end
end

CoD.RoundStatus.ShowFirstRoundFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender:beginAnimation("idle", CoD.RoundStatus.FirstRoundIdleDuration)
    end
end

CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender:beginAnimation("fade_out", CoD.RoundStatus.FirstRoundDuration)
        Sender:setAlpha(0)
    end
end

CoD.RoundStatus.ShowFirstRoundTextIdleFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
        Sender:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
        Sender:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    end
end

CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
        Sender:setLeftRight(true, false, CoD.RoundStatus.LeftOffset, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize)
        Sender:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    end
end

CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
        Sender:setLeftRight(true, false, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize, CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2)
        Sender:setTopBottom(false, true, CoD.RoundStatus.ChalkTop, CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize)
    end
end

CoD.RoundStatus.StartNewRound = function(HudRef, roundsPlayed, wasDemoJump)
    if roundsPlayed <= 5 then
        HudRef.roundChalk1:setAlpha(1)

        if wasDemoJump == true then
            HudRef.roundChalk1:completeAnimation()
            HudRef.roundChalk1:setAlpha(1)
            HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
            HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[roundsPlayed])
        else
            if 1 < roundsPlayed then
                HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[roundsPlayed - 1])
            end

            HudRef.roundChalk1.pulseTimes = 0
            HudRef.roundChalk1.material = CoD.RoundStatus.Chalks[roundsPlayed]
            HudRef.roundChalk1.showInLastPulse = true
            HudRef.roundChalk1.showInPreviousPulses = true
            HudRef.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk1:setAlpha(0)
            HudRef.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
        end

        HudRef.roundChalk2:completeAnimation()
        HudRef.roundChalk2:setAlpha(0)
        HudRef.roundText:completeAnimation()
        HudRef.roundText:setAlpha(0)
    elseif roundsPlayed == 6 then
        HudRef.roundChalk1:setAlpha(1)
        HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])

        if wasDemoJump == true then
            HudRef.roundChalk2:setAlpha(1)
            HudRef.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
            HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
        else
            HudRef.roundChalk1.pulseTimes = 0
            HudRef.roundChalk1.material = CoD.RoundStatus.Chalks[5]
            HudRef.roundChalk1.showInLastPulse = true
            HudRef.roundChalk1.showInPreviousPulses = true
            HudRef.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk1:setAlpha(0)
            HudRef.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)

            HudRef.roundChalk2.pulseTimes = 0
            HudRef.roundChalk2.material = CoD.RoundStatus.Chalks[roundsPlayed - 5]
            HudRef.roundChalk2.showInLastPulse = true
            HudRef.roundChalk2.showInPreviousPulses = false
            HudRef.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk2:setAlpha(0)
            HudRef.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
        end

        HudRef.roundText:completeAnimation()
        HudRef.roundText:setAlpha(0)
    elseif roundsPlayed <= 10 then
        HudRef.roundChalk1:setAlpha(1)
        HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])

        HudRef.roundChalk2:setAlpha(1)
        HudRef.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[roundsPlayed - 5 - 1])

        if wasDemoJump == true then
            HudRef.roundChalk1:setAlpha(1)

            HudRef.roundChalk2:setAlpha(1)
            HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[roundsPlayed - 5])
        else
            HudRef.roundChalk1.pulseTimes = 0
            HudRef.roundChalk1.material = CoD.RoundStatus.Chalks[5]
            HudRef.roundChalk1.showInLastPulse = true
            HudRef.roundChalk1.showInPreviousPulses = true
            HudRef.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk1:setAlpha(0)
            HudRef.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)

            HudRef.roundChalk2.pulseTimes = 0
            HudRef.roundChalk2.material = CoD.RoundStatus.Chalks[roundsPlayed - 5]
            HudRef.roundChalk2.showInLastPulse = true
            HudRef.roundChalk2.showInPreviousPulses = true
            HudRef.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk2:setAlpha(0)
            HudRef.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
        end

        HudRef.roundText:completeAnimation()
        HudRef.roundText:setAlpha(0)
    elseif roundsPlayed == 11 then
        HudRef.roundChalk1:setAlpha(1)
        HudRef.roundChalk1:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])

        HudRef.roundChalk2:setAlpha(1)
        HudRef.roundChalk2:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundChalk2:setImage(CoD.RoundStatus.Chalks[5])

        if wasDemoJump == true then
            HudRef.roundChalk1:setAlpha(0)
            HudRef.roundChalk2:setAlpha(0)

            HudRef.roundText:setAlpha(1)
            HudRef.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
            HudRef.roundText:setText(roundsPlayed)
        else
            HudRef.roundChalk1.pulseTimes = 0
            HudRef.roundChalk1.material = CoD.RoundStatus.Chalks[5]
            HudRef.roundChalk1.showInLastPulse = false
            HudRef.roundChalk1.showInPreviousPulses = true
            HudRef.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk1:setAlpha(0)
            HudRef.roundChalk1:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)

            HudRef.roundChalk2.pulseTimes = 0
            HudRef.roundChalk2.material = CoD.RoundStatus.Chalks[5]
            HudRef.roundChalk2.showInLastPulse = false
            HudRef.roundChalk2.showInPreviousPulses = true
            HudRef.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundChalk2:setAlpha(0)
            HudRef.roundChalk2:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)

            HudRef.roundText.pulseTimes = 0
            HudRef.roundText.material = roundsPlayed
            HudRef.roundText.showInLastPulse = true
            HudRef.roundText.showInPreviousPulses = false
            HudRef.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundText:setAlpha(0)
            HudRef.roundText:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
        end
    else
        HudRef.roundText:setAlpha(1)
        HudRef.roundText:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
        HudRef.roundText:setText(roundsPlayed - 1)

        if wasDemoJump == true then
            HudRef.roundText:setText(roundsPlayed)
        else
            HudRef.roundText.pulseTimes = 0
            HudRef.roundText.material = roundsPlayed
            HudRef.roundText.showInLastPulse = true
            HudRef.roundText.showInPreviousPulses = true
            HudRef.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            HudRef.roundText:setAlpha(0)
            HudRef.roundText:setRGB(CoD.RoundStatus.AlternatePulseColor.r, CoD.RoundStatus.AlternatePulseColor.g, CoD.RoundStatus.AlternatePulseColor.b)
        end

        HudRef.roundChalk1:completeAnimation()
        HudRef.roundChalk1:setAlpha(0)
        HudRef.roundChalk2:completeAnimation()
        HudRef.roundChalk2:setAlpha(0)
    end
end

CoD.RoundStatus.RoundSwitchShowFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        Sender.pulseTimes = Sender.pulseTimes + 1

        if Sender.pulseTimes <= CoD.RoundStatus.RoundPulseTimes then
            if CoD.RoundStatus.RoundPulseTimes - 1 < Sender.pulseTimes then
                Sender:beginAnimation("round_switch_hide", CoD.RoundStatus.FirstRoundDuration)
                Sender:setRGB(CoD.RoundStatus.DefaultColor.r, CoD.RoundStatus.DefaultColor.g, CoD.RoundStatus.DefaultColor.b)
            else
                Sender:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
            end

            Sender:setAlpha(0)
        end
    end
end

CoD.RoundStatus.RoundSwitchHideFinish = function(Sender, Event)
    if Event.interrupted ~= true then
        local alpha = 1
        if CoD.RoundStatus.RoundPulseTimes - 1 < Sender.pulseTimes then
            if type(Sender.material) == "number" then
                Sender:setText(Sender.material)
            else
                Sender:setImage(Sender.material)
            end

            if Sender.showInLastPulse == false then
                alpha = 0
            end

            Sender:beginAnimation("round_switch_show", CoD.RoundStatus.FirstRoundDuration)
        else
            if Sender.showInPreviousPulses == false then
                alpha = 0
            end

            Sender:beginAnimation("round_switch_show", CoD.RoundStatus.RoundPulseDuration)
        end

        Sender:setAlpha(alpha)
    end
end

CoD.RoundStatus.UpdateTeamChange = function (Sender, Event)
    if Sender.team ~= Event.team and type(Event.team) == "number" and Event.team < CoD.TEAM_SPECTATOR then
        Sender.team = Event.team
        if Sender.team ~= CoD.TEAM_FREE then
            local team = Engine.GetFactionForTeam(Event.team)
            -- todo: gamegroups aren't used anymore
            if team ~= "" and Sender.gameTypeGroup == CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
                local f13_local1 = Dvar.ui_gametype
                if f13_local1:get() == CoD.Zombie.GAMETYPE_ZCLEANSED and Sender.team == CoD.TEAM_AXIS then
                    team = "zombie"
                else
                    f13_local1 = Dvar.ui_gametype
                    if f13_local1:get() == CoD.Zombie.GAMETYPE_ZMEAT and Sender.team == CoD.TEAM_AXIS then
                        team = "cia"
                    end
                end
                Sender.factionIcon:setImage(RegisterImage("faction_" .. team))
                Sender.factionIcon:setAlpha(1)
            else
                Sender.factionIcon:setAlpha(0)
            end
        else
            Sender.factionIcon:setAlpha(0)
        end
    end
end

CoD.RoundStatus.HideAllRoundIcons = function(HudRef, Event)
    HudRef.roundTextCenter:setAlpha(0)
    HudRef.roundText:setAlpha(0)
    HudRef.roundChalk1:setAlpha(0)
    HudRef.roundChalk2:setAlpha(0)
end

CoD.RoundStatus.TimeBombRoundAnimationOverride = function (HudRef, Event)
    if Event.newValue == 1 then
        HudRef.timebombOverride = true
    else
        HudRef.timebombOverride = false
    end
end

