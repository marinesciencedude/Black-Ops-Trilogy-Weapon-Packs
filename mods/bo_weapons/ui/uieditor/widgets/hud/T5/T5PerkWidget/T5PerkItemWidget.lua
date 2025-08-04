CoD.T5PerkItemWidget = InheritFrom(LUI.UIElement)

function CoD.T5PerkItemWidget.new(menu, controller)
    local self = LUI.UIElement.new()
    self:setClass(CoD.T5PerkItemWidget)
    self.id = "T5PerkItemWidget"
    self.anyChildUsesUpdateState = true

    self:setLeftRight( true, false, 0, 36 )
    self:setTopBottom( true, false, 0, 36 )

    self.PerkImage = LUI.UIImage.new()
    self.PerkImage:setLeftRight(true, false, 0, 36)
    self.PerkImage:setTopBottom(false, true, -36, 0)
    self:addElement( self.PerkImage )

    self.PerkImage:linkToElementModel( self, "image", true, function( ModelRef )
        local ModelValue = Engine.GetModelValue( ModelRef )
        if ModelValue then
            self.PerkImage:setImage( RegisterMaterial( ModelValue ) )
        end
    end)

    self:linkToElementModel( self, "status", true, function( ModelRef )
        menu:updateElementState( self, {
            name = "model_validation",
            menu = menu,
            modelValue = Engine.GetModelValue(ModelRef),
            modelName = "status"
        } )
    end )

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                self.PerkImage:completeAnimation()
                self.PerkImage:setAlpha( 1 )
                self.PerkImage:setScale( 1 )
                self.clipFinished(self.PerkImage, {})
            end
        },
        Enabled = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )
                
                self.PerkImage:completeAnimation()
                self.PerkImage:setAlpha( 1 )
                self.PerkImage:setScale( 1 )
                self.clipFinished(self.PerkImage, {})
            end,
            Intro = function()
                self:setupElementClipCounter(1)

                self.PerkImage:completeAnimation()
                self.PerkImage:setAlpha( 1 )
                self.PerkImage:setScale( 1 )
                self.clipFinished(self.PerkImage, {})
            end
        },
        Paused = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )
                
                self.PerkImage:completeAnimation()
                self.PerkImage:beginAnimation( "pulse", 200 )
                self.PerkImage:setScale( 1.3 )
                self.PerkImage:beginAnimation( "pulse", 200 )
                if Engine.GetCurrentMap() ~= "zm_cosmodrome" then
                    self.PerkImage:setAlpha( 0.3 )
                end
                self.PerkImage:setScale( 1 )
                self.clipFinished(self.PerkImage, {})
            end
        }
    }

    self.StateTable = {
        {
            stateName = "Enabled",
            condition = function( menu, element, event )
                return IsSelfModelValueEqualTo(element, controller, "status", 1)
            end
        },
        {
            stateName = "Paused",
            condition = function( menu, element, event )
                return IsSelfModelValueEqualTo(element, controller, "status", 2)
            end
        }
    }
    self:mergeStateConditions(self.StateTable)

    LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(arg0, arg1)
        if IsSelfModelValueTrue(arg0, controller, "newPerk") then
            PlayClip(self, "Intro", controller)
        end

        SetSelfModelValue(self, arg0, controller, "newPerk", false)

    end)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function( element )
        element.PerkImage:close()
    end)

    return self
end