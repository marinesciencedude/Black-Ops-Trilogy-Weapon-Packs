CoD.T5OffhandSlotsWidget = InheritFrom( LUI.UIElement )

function CoD.T5OffhandSlotsWidget.new( menu, controller )

    local self = LUI.UIElement.new()
    self:setClass(CoD.T5OffhandSlotsWidget)
    self.id = "T5OffhandSlotsWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self.Icon = "blacktransparent"
    self.Count = 0

    self.setCount = function(self, Count)
        self.Count = Count

        if self.icons == nil then
            self.icons = {}
        end

        for index=1, self.Count do
            if not self.icons[index] then
                -- Create grenade icon
                self.icons[index] = LUI.UIImage.new()
                --self.icons[index]:setLeftRight(false, true, -((index-1)*24)-24, -(index-1)*24)
                self.icons[index]:setLeftRight(false, true, -24 - (4*index), 0 - (4*index))
                self.icons[index]:setTopBottom(false, true, -24, 0)
                self.icons[index]:setAlpha(index / self.Count)
                self.icons[index]:setImage(RegisterImage(self.Icon))
                self:addElement(self.icons[index])
            else
                -- Grenade icon exists, just change alpha
                self.icons[index]:setAlpha(index / self.Count)
            end
        end
        -- Close old grenade icons
        for index=#self.icons, self.Count+1, -1 do
            if self.icons[index] then
                self.icons[index]:close()
                self.icons[index] = nil
            end
        end
    end

    self.setIcon = function(self, Icon)
        if Icon == "t7_zm_derriese_hud_homing_beacon" then
            Icon = "t6hud_homing_beacon"

        elseif Icon == "hud_cymbal_monkey_bo3" then
            Icon = "t5hud_cymbal_monkey"

        elseif Icon == "t7_zm_derriese_hud_blackhole" then
            Icon = "hud_blackhole"

        elseif Icon == "t7_zm_derriese_hud_doll" then
            Icon = "hud_nestingbomb"
            
        elseif Icon == "t7_zm_derriese_hud_quantum" then
            Icon = "hud_quantum_bomb"
        end
        self.Icon = Icon
        for index=1, #self.icons do
            self.icons[index]:setImage(RegisterImage(self.Icon))
        end
    end

    self.setAmmoModel = function(self, ModelName)
        self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelName), function(ModelRef)
            if Engine.GetModelValue(ModelRef) then
                self:setCount(Engine.GetModelValue(ModelRef))
            end
        end)
    end

    self.setIconModel = function(self, ModelName)
        self:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), ModelName), function(ModelRef)
            if Engine.GetModelValue(ModelRef) then
                self:setIcon(Engine.GetModelValue(ModelRef))
            end
        end)
    end

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(0)
            end
        }
    }

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(self)
        for index=#self.icons, 1, -1 do
            self.icons[index]:close()
        end
    end)

    return self
end