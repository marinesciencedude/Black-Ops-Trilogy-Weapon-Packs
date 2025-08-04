require("ui.uieditor.widgets.MPHudWidgets.Waypoint")

CoD.T5ReviveWidget = InheritFrom(LUI.UIElement)

local function HandleModels(self, controller, menu)
    local reviveIndicatorModel = DataSources.WorldSpaceIndicators.getModel(controller)
    local bleedOutModel = Engine.GetModel(reviveIndicatorModel, ("bleedOutModel" .. string.sub(self.objective.id, -1)))
    local revivingFlagModel = Engine.CreateModel(bleedOutModel, "reviving")
    local bleedOutPercentModel = Engine.GetModel(bleedOutModel, "bleedOutPercent")
    local clockPercentModel = Engine.GetModel(bleedOutModel, "clockPercent")
    local playerNameModel = Engine.GetModel(bleedOutModel, "playerName")
    self:setModel(bleedOutModel, controller)
    self:linkToElementModel(self, "reviving", true, function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            local revivingFlag = Engine.GetModelValue(ModelRef)
            self.revivingFlag = revivingFlag
            
            if revivingFlag == 1 then
                self.Waypoint:setRGB(1, 1, 1)
                --self.ProgressBar:setAlpha(1)
            else
                self.Waypoint:setRGB(1, Engine.GetModelValue(bleedOutPercentModel), 0)
                --self.ProgressBar:setAlpha(0)
            end
        end
    end)

    self:linkToElementModel(self, "bleedOutPercent", true, function(ModelRef)
        if Engine.GetModelValue(ModelRef) then
            local vectorString = Engine.GetModelValue(ModelRef)
            local bleedPercent = CoD.GetVectorComponentFromString(vectorString, 1)
            self.storedBleedPercent = bleedOutPercent

            if self.revivingFlag == 0 then
                self.Waypoint:setRGB(1, bleedPercent, 0)
                --if bleedPercent == 1 then
                --    if self.NotifText then
                --        self.NotifText:ShowForDuration(2000)
                --    end
                --end
            end
        end
    end)
end

local function PostLoadCallback(self, controller, menu)
    self.update = function(self, Objective)
        self.Waypoint:update(Objective)
    end

    self.shouldShow = function(self, Objective)
        return true
    end

    self.setupWaypointContainer = function(self, Objective)
        if Objective.objId then
            self.objId = Objective.objId
            self.Waypoint.objective = self.objective
            self.Waypoint:setupWaypoint(Objective)
            self.Waypoint.WaypointCenter.waypointCenterImage:setImage(RegisterImage(self.Waypoint.waypoint_image_default))
            
            HandleModels(self, controller, menu)
        end
    end

    -- 9/2/19 - Fixes progressbar updating to reflect when user has Quick Revive Perk
    -- self.hasQR = false
end

function CoD.T5ReviveWidget.new(menu, controller)
    local self = LUI.UIElement.new()
    self:setClass(CoD.T5ReviveWidget)
    self.id = "T5ReviveWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self:setLeftRight(true, false, 0, 1280)
    self:setTopBottom(true, false, 0, 720)

    local ScaleContainer = CoD.SplitscreenScaler.new( nil, 1.2 )
    ScaleContainer:setLeftRight( true, false, 0, 0 )
    ScaleContainer:setTopBottom( true, false, 0, 0 )

    self:addElement(ScaleContainer)
    self.ScaleContainer = ScaleContainer

    self.storedBleedPercent = 1
    self.storedClockPercent = 0
    self.revivingFlag = 0

    --self.NotifText = nil

    local Waypoint = CoD.Waypoint.new( menu, controller )
    Waypoint:setLeftRight( false, false, -128, 128 )
    Waypoint:setTopBottom( false, false, -128, 128 )
    Waypoint:setRGB( 1, 1, 0 )
    self.ScaleContainer:addElement( Waypoint )
    self.Waypoint = Waypoint

    self.Waypoint.WaypointText:setState( "NoText" )
    self.Waypoint.WaypointCenter.waypointCenterImage:setScale( 1.25 )

    --self.ProgressBar = CoD.ProgressBarWithTextWidget.new(menu, controller, "Reviving")
    --self.ProgressBar:setAlpha(0)
    --self:addElement(self.ProgressBar)
    
    if PostLoadCallback then
        PostLoadCallback(self, controller, menu)
    end

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
        element.Waypoint:close()

    end)

    return self
end