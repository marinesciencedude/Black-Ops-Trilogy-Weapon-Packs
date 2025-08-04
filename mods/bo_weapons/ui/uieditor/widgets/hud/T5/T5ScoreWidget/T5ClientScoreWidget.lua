require( "UI.UIEditor.Widgets.HUD.T5.T5ScoreWidget.T5GlowScoreWidget" )
require( "ui.uieditor.widgets.hud.T5.UIShadowText" )

CoD.T5ClientScoreWidget = InheritFrom( LUI.UIElement )

function CoD.T5ClientScoreWidget.new( menu, controller )
    local self = LUI.UIElement.new()
    self:setClass(CoD.T5ClientScoreWidget)
    self.id = "T5ClientScoreWidget"
    self.soundSet = "default"
    self.anyChildUsesUpdateState = true

    self:setLeftRight(false, true, -CoD.T5ScoreWidget.RowWidth, -CoD.T5ScoreWidget.ClientRowWidth )
    self:setTopBottom(false, true, (((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 2)) - CoD.T5ScoreWidget.RowHeight) - 1.5), ((CoD.T5ScoreWidget.Bottom - (CoD.T5ScoreWidget.RowHeight * 2)) + 1.5))

    self.oldScore = CoD.T5ScoreWidget.StartingPoints

    local ScoreBG = LUI.UIImage.new()
    ScoreBG:setLeftRight(true, true, 0, 0)
    ScoreBG:setTopBottom(true, true, 0, 0)
    ScoreBG:setRGB(0.48, 0, 0)
    ScoreBG:setImage(RegisterImage("scorebar_zom_1"))

    self:addElement(ScoreBG)
    self.ScoreBG = ScoreBG

    local ScoreText = CoD.UIShadowText.new( menu, controller )
    ScoreText:setLeftRight(true, false, 0, 137.5)
    ScoreText:setTopBottom(true, true, 0, 0)
    ScoreText.TextShadow:setRGB( 0.0, 0.0, 0.0 )
    ScoreText:setTTF("fonts/helveticaneue.ttf")
    ScoreText:setScale(0.8)

    self:addElement(ScoreText)
    self.ScoreText = ScoreText

    local InventoryIcon = LUI.UIImage.new()
    InventoryIcon:setLeftRight(false, true, -78, -46)
    InventoryIcon:setTopBottom(false, false, -15, 15)

    self:addElement(InventoryIcon)
    self.InventoryIcon = InventoryIcon

    local WearableImage = LUI.UIImage.new()
    WearableImage:setLeftRight(false, true, -32, 0)
    WearableImage:setTopBottom(false, false, -15, 15)

    self:addElement(WearableImage)
    self.WearableImage = WearableImage

    self.InventoryIcon:linkToElementModel(self, "zombieInventoryIcon", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) and Engine.GetCurrentMap() ~= "zm_moon" then
            self.InventoryIcon:setImage(RegisterImage(Engine.GetModelValue( ModelRef )))
        else
            self.InventoryIcon:setImage(RegisterImage("blacktransparent"))
        end
    end)

    self.WearableImage:linkToElementModel(self, "zombieWearableIcon", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) and Engine.GetCurrentMap() ~= "zm_moon" then         
            self.WearableImage:setImage(RegisterImage(Engine.GetModelValue( ModelRef )))
        else
            self.WearableImage:setImage(RegisterImage("blacktransparent"))
        end
    end)

    local function UpdateScore(newScore)
        local scoreDiff = 0
        local isPositive = true

        if self.oldScore > newScore then
            scoreDiff = self.oldScore - newScore
            isPositive = false
        elseif self.oldScore == newScore then
            return
        else
            scoreDiff = newScore - self.oldScore
        end

        self.oldScore = newScore

        self:addElement(CoD.T5GlowScoreWidget.new(menu, controller, scoreDiff, isPositive, 0.75))
    end

    self.ScoreText:linkToElementModel(self, "clientNum", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            self.ScoreText:setRGB( CoD.T5ScoreWidget.GetScoreBarColor( Engine.GetModelValue( ModelRef ) ) )
            self.ScoreBG:setImage( RegisterImage( "scorebar_zom_" .. ( Engine.GetModelValue( ModelRef ) + 1 ) ) )
        end
    end)

    self.ScoreText:linkToElementModel(self, "playerScore", true, function( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            UpdateScore( Engine.GetModelValue( ModelRef ) )
            self.ScoreText:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
        end
    end)

    self.StateTable = {
        {
            stateName = "Visible",
            condition = function(menu, ItemRef, UpdateTable)
                return not IsSelfModelValueEqualTo(ItemRef, controller, "playerScoreShown", 0)
            end
        }
    }
    self:mergeStateConditions(self.StateTable)

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter(2)

                self.ScoreBG:completeAnimation()
                self.ScoreBG:setAlpha(0)
                self.clipFinished(self.ScoreBG, {})

                self.ScoreText:completeAnimation()
                self.ScoreText:setAlpha(0)
                self.clipFinished(self.ScoreText, {})
            end,
            Visible = function()
                local function HandleScoreTextClipStage1(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                    end
                    Sender:setAlpha(1)
                    if Event.interrupted then
                        self.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                    end
                end

                local function HandleScoreBGClipStage1(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                    end
                    Sender:setAlpha(1)
                    if Event.interrupted then
                        self.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                    end
                end

                self:setupElementClipCounter(2)

                self.ScoreBG:completeAnimation()
                self.ScoreBG:setAlpha(0)
                HandleScoreBGClipStage1(self.ScoreBG,{})

                self.ScoreText:completeAnimation()
                self.ScoreText:setAlpha(0)
                HandleScoreTextClipStage1(self.ScoreText,{})
            end
        },
        Visible = {
            DefaultClip = function()
                self:setupElementClipCounter(2)

                self.ScoreBG:completeAnimation()
                self.ScoreBG:setAlpha(1)
                self.clipFinished(self.ScoreBG, {})

                self.ScoreText:completeAnimation()
                self.ScoreText:setAlpha(1)
                self.clipFinished(self.ScoreText, {})
            end,
            DefaultState = function()
                local function HandleScoreTextClipStage1(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                    end
                    Sender:setAlpha(0)
                    if Event.interrupted then
                        self.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                    end
                end

                local function HandleScoreBGClipStage1(Sender, Event)
                    if not Event.interrupted then
                        Sender:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Linear)
                    end
                    Sender:setAlpha(0)
                    if Event.interrupted then
                        self.clipFinished(Sender, Event)
                    else
                        Sender:registerEventHandler("transition_complete_keyframe", self.clipFinished)
                    end
                end

                self:setupElementClipCounter(2)

                self.ScoreBG:completeAnimation()
                self.ScoreBG:setAlpha(1)
                HandleScoreBGClipStage1(self.ScoreBG,{})

                self.ScoreText:completeAnimation()
                self.ScoreText:setAlpha(1)
                HandleScoreTextClipStage1(self.ScoreText,{})
            end
        }
    }

    self:linkToElementModel(self, "playerScoreShown", true, function(ModelRef)
        menu:updateElementState(self, {
            name = "model_validation",
            menu = menu,
            modelValue = Engine.GetModelValue(ModelRef),
            modelName = "playerScoreShown"
        })
    end)

    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
        element.ScoreText:close()
        element.ScoreBG:close()
        element.InventoryIcon:close()
        element.WearableImage:close()
    end)

    return self
end