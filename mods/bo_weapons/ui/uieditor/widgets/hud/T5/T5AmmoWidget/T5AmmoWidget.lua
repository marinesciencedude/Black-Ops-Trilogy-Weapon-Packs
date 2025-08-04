-- Lilrifa Util Require --
require( "UI.LilrifaUtils" )
require( "UI.SubscriptionUtils" )
require( "UI.T7FontLoader" )

require( "ui.uieditor.widgets.hud.T5.UIShadowText" )
require( "ui.uieditor.widgets.hud.T5.T5AmmoWidget.T5OffhandSlotsWidget" )
require( "ui.uieditor.widgets.hud.T5.T5AmmoWidget.T5AmmoDPADWidget" )

--[[
- how to translate bo1 menu to bo3 lua

multiply all values by 1.5 (scales from 480p to 720p)
anchors are always false, true
the start value will always be right after true
in order to get the correct length and width, take the start number and subtract the other asscioated with it and negate the number.

gsc values are doubled

]]
CoD.T5AmmoWidget = InheritFrom( LUI.UIElement )

-- ammo and low ammo colors
CoD.T5AmmoWidget.AmmoColor = { r = 0.74, g = 0.84, b = 0.86 }
CoD.T5AmmoWidget.LowAmmoColor = { r = 0.943, g = 0.345, b = 0.373 }

function CoD.T5AmmoWidget.new( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
        PreLoadFunc( self, controller )
    end

    self:setClass( CoD.T5AmmoWidget )
    self.id = "T5AmmoWidget"
    self.soundSet = "HUD"
    self.anyChildUsesUpdateState = true

    FontLoader( self, { "morrissans", "helveticaneue" } )

    local ScaleContainer = CoD.SplitscreenScaler.new( nil, 1.2 )
    ScaleContainer:setLeftRight( false, true, 0, 0 )
    ScaleContainer:setTopBottom( false, true, 0, 0 )

    self:addElement(ScaleContainer)
    self.ScaleContainer = ScaleContainer

    local DPADParent = LUI.UIElement.new()
    DPADParent:setLeftRight( true, true, 0, 0 )
    DPADParent:setTopBottom( true, true, 0, 0 )

    self.ScaleContainer:addElement( DPADParent )
    self.DPADParent = DPADParent

-- background--------------------------------------------------------------------------------------------------------------

    local BloodSplat = LUI.UIImage.new()
    BloodSplat:setLeftRight( false, true, -270, 6 )
    BloodSplat:setTopBottom( false, true, -133.5, 4.5 )
    BloodSplat:setAlpha( 1.0 )
    BloodSplat:setRGB( 0.21, 0, 0 )
    BloodSplat:setImage( RegisterImage( "hud_dpad_blood_bo1" ) )

    self.DPADParent:addElement( BloodSplat )
    self.BloodSplat = BloodSplat


    local DPADLinesFade = LUI.UIImage.new()
    DPADLinesFade:setLeftRight( false, true, -271.5, -79.5 )
    DPADLinesFade:setTopBottom( false, true, -84, 9 )
    DPADLinesFade:setAlpha( 0.6 )
    DPADLinesFade:setRGB( 1, 1, 1 )
    DPADLinesFade:setImage( RegisterImage( "hud_dpad_lines_fade" ) )

    self.DPADParent:addElement( DPADLinesFade )
    self.DPADLinesFade = DPADLinesFade


    local DPADLines = LUI.UIImage.new()
    DPADLines:setLeftRight( false, true, -274.5, -72.5 )
    DPADLines:setTopBottom( false, true, -84, 12 )
    DPADLines:setAlpha( 0.8 )
    DPADLines:setRGB( 1, 1, 1 )
    DPADLines:setImage( RegisterImage( "hud_dpad_lines" ) )

    self.DPADParent:addElement( DPADLines )
    self.DPADLines = DPADLines

-- weapon text--------------------------------------------------------------------------------------------------------------

    local DPADWeaponParent = LUI.UIElement.new()
    DPADWeaponParent:setLeftRight( true, true, 0, 0 )
    DPADWeaponParent:setTopBottom( true, true, 0, 0 )

    self.DPADParent:addElement( DPADWeaponParent )
    self.DPADWeaponParent = DPADWeaponParent


    local WeaponAmmo = CoD.UIShadowText.new( menu, controller )
    WeaponAmmo.Left = -204
    WeaponAmmo.Right = -154
    WeaponAmmo:setLeftRight( false, true, WeaponAmmo.Left, WeaponAmmo.Right )
    WeaponAmmo:setTopBottom( false, true, -73.5, -18.5 )
    WeaponAmmo:setText( "0" )
    WeaponAmmo:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
    WeaponAmmo:setTTF( "fonts/morrissans.ttf" )
    WeaponAmmo:setScale( 0.55 )
    WeaponAmmo:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )

    WeaponAmmo:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInClip", function ( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            WeaponAmmo:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
        end
    end)

    WeaponAmmo.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                WeaponAmmo:setupElementClipCounter( 2 )
                
                WeaponAmmo.Text:completeAnimation()
                WeaponAmmo.Text:setAlpha( 1.0 )
                WeaponAmmo.clipFinished( WeaponAmmo.Text, {} )

                WeaponAmmo.TextShadow:completeAnimation()
                WeaponAmmo.TextShadow:setAlpha( 1.0 )
                WeaponAmmo.clipFinished( WeaponAmmo.TextShadow, {} )
            end
        },
        LowAmmo = {
            DefaultClip = function()
                WeaponAmmo:setupElementClipCounter( 1 )

                local function HandleLowAmmoClip(Element, Event)
                    local function HandleLowAmmoClipStage2(Element, Event)
                        if not Event.interrupted then
                            Element:beginAnimation( "keyframe", 500, true, true, CoD.TweenType.Linear)
                        end

                        Element:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )

                        if Event.interrupted then
                            WeaponAmmo.clipFinished(Element, Event)
                        else
                            Element:registerEventHandler( "transition_complete_keyframe", WeaponAmmo.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleLowAmmoClipStage2(Element, Event)
                        return
                    end

                    Element:beginAnimation( "keyframe", 500, true, true, CoD.TweenType.Linear)
                    Element:setRGB( CoD.T5AmmoWidget.LowAmmoColor.r, CoD.T5AmmoWidget.LowAmmoColor.g, CoD.T5AmmoWidget.LowAmmoColor.b )
                    Element:registerEventHandler( "transition_complete_keyframe", HandleLowAmmoClipStage2)
                end

                WeaponAmmo.Text:completeAnimation()
                WeaponAmmo.Text:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
                HandleLowAmmoClip(WeaponAmmo.Text, {})

                WeaponAmmo.nextClip = "DefaultClip"
            end
        }
    }

    WeaponAmmo.StateTable = {
        {
            stateName = "LowAmmo",
            condition = function( menu, element, event )
                return IsLowAmmoClip( controller ) and not ( ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "elemental_bow" ) )
            end
        }
    }

    WeaponAmmo:mergeStateConditions( WeaponAmmo.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, WeaponAmmo, "CurrentWeapon.ammoInClip" )
    SubscribeToModelAndUpdateState( controller, menu, WeaponAmmo, "CurrentWeapon.weapon" )

    self.DPADWeaponParent:addElement( WeaponAmmo )
    self.WeaponAmmo = WeaponAmmo


    local DWDividerLine = LUI.UIImage.new()
    DWDividerLine.Left = -200
    DWDividerLine.Right = -198
    DWDividerLine:setLeftRight( false, true, -200, -198 )
    DWDividerLine:setTopBottom( false, true, -58.5, -31.5 )
    DWDividerLine:setAlpha( 0.4 )
    DWDividerLine:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
    DWDividerLine:setImage( RegisterImage( "$white" ) )

    self.DPADWeaponParent:addElement( DWDividerLine )
    self.DWDividerLine = DWDividerLine


    local WeaponAmmoDW = CoD.UIShadowText.new( menu, controller )
    WeaponAmmoDW.Left = -254
    WeaponAmmoDW.Right = -204
    WeaponAmmoDW:setLeftRight( false, true, WeaponAmmoDW.Left, WeaponAmmoDW.Right )
    WeaponAmmoDW:setTopBottom( false, true, -73.5, -18.5 )
    WeaponAmmoDW:setText( "0" )
    WeaponAmmoDW:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
    WeaponAmmoDW:setTTF( "fonts/morrissans.ttf" )
    WeaponAmmoDW:setScale( 0.55 )
    WeaponAmmoDW:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )

    WeaponAmmoDW:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInDWClip", function ( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            if Engine.GetModelValue( ModelRef ) > -1 then
                WeaponAmmoDW:setAlpha( 1.0 )
                DWDividerLine:setAlpha( 0.4 )
                WeaponAmmoDW:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )
            else
                WeaponAmmoDW:setAlpha( 0.0 )
                DWDividerLine:setAlpha( 0.0 )
            end
        end
    end)

    WeaponAmmoDW.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                WeaponAmmoDW:setupElementClipCounter( 2 )
                
                WeaponAmmoDW.Text:completeAnimation()
                WeaponAmmoDW.Text:setAlpha( 1.0 )
                WeaponAmmoDW.clipFinished( WeaponAmmoDW.Text, {} )

                WeaponAmmoDW.TextShadow:completeAnimation()
                WeaponAmmoDW.TextShadow:setAlpha( 1.0 )
                WeaponAmmoDW.clipFinished( WeaponAmmoDW.TextShadow, {} )
            end
        },
        LowAmmo = {
            DefaultClip = function()
                WeaponAmmoDW:setupElementClipCounter( 1 )

                local function HandleLowAmmoClip(Element, Event)
                    local function HandleLowAmmoClipStage2(Element, Event)
                        if not Event.interrupted then
                            Element:beginAnimation( "keyframe", 500, true, true, CoD.TweenType.Linear)
                        end

                        Element:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )

                        if Event.interrupted then
                            WeaponAmmoDW.clipFinished(Element, Event)
                        else
                            Element:registerEventHandler( "transition_complete_keyframe", WeaponAmmoDW.clipFinished)
                        end
                    end

                    if Event.interrupted then
                        HandleLowAmmoClipStage2(Element, Event)
                        return
                    end

                    Element:beginAnimation( "keyframe", 500, true, true, CoD.TweenType.Linear)
                    Element:setRGB( CoD.T5AmmoWidget.LowAmmoColor.r, CoD.T5AmmoWidget.LowAmmoColor.g, CoD.T5AmmoWidget.LowAmmoColor.b )
                    Element:registerEventHandler( "transition_complete_keyframe", HandleLowAmmoClipStage2)
                end

                WeaponAmmoDW.Text:completeAnimation()
                WeaponAmmoDW.Text:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
                HandleLowAmmoClip(WeaponAmmoDW.Text, {})

                WeaponAmmoDW.nextClip = "DefaultClip"
            end
        }
    }

    WeaponAmmoDW.StateTable = {
        {
            stateName = "LowAmmo",
            condition = function( menu, element, event )
                return IsLowAmmoDWClip( controller ) and not ( ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "elemental_bow" ) )
            end
        }
    }

    WeaponAmmoDW:mergeStateConditions( WeaponAmmoDW.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, WeaponAmmoDW, "CurrentWeapon.ammoInDWClip" )
    SubscribeToModelAndUpdateState( controller, menu, WeaponAmmoDW, "CurrentWeapon.weapon" )

    self.DPADWeaponParent:addElement( WeaponAmmoDW )
    self.WeaponAmmoDW = WeaponAmmoDW


    local WeaponStock = CoD.UIShadowText.new( menu, controller )
    WeaponStock:setLeftRight( false, true, -170, -120 )
    WeaponStock:setTopBottom( false, true, -71.5, -16.5 )
    WeaponStock:setText( "0" )
    WeaponStock:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
    WeaponStock:setTTF( "fonts/morrissans.ttf" )
    WeaponStock:setScale( 0.4000 )
    --WeaponStock:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )

    self.DPADWeaponParent:addElement( WeaponStock )
    self.WeaponStock = WeaponStock

    local function UpdateStockAmmo( ModelRef )
        local stock = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoStock" ) )
        if stock then
            self.WeaponStock:setText( " / " .. Engine.Localize( stock ) )

            local ClipMax = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.clipMaxAmmo" ) )
            if stock <= ClipMax then
                self.WeaponStock:setRGB( CoD.T5AmmoWidget.LowAmmoColor.r, CoD.T5AmmoWidget.LowAmmoColor.g, CoD.T5AmmoWidget.LowAmmoColor.b )
            else
                self.WeaponStock:setRGB( CoD.T5AmmoWidget.AmmoColor.r, CoD.T5AmmoWidget.AmmoColor.g, CoD.T5AmmoWidget.AmmoColor.b )
            end
        end

        local leftClip = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInDWClip" ) )
        local rightClip = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInClip" ) )

        if not rightClip or not leftClip then
            return
        end

        local rightClipPush = ( #tostring( rightClip ) - 1 ) * 0.5

        local stockPush = ( #tostring( stock ) - 1 ) * 1.8
        if self.DPADWeaponParent.currentState == "DoesNotUseStockAmmo" then
            stockPush = 0
        end

        self.WeaponAmmo:setLeftRight( false, true, ( ( self.WeaponAmmo.Left - ( 25 * rightClipPush ) ) - ( 25 * stockPush ) ), self.WeaponAmmo.Right )

        if leftClip < 0 then
            return
        end

        self.DWDividerLine:setLeftRight( false, true, ( ( self.DWDividerLine.Left - ( 25 * rightClipPush ) ) - ( 5 * stockPush ) ), ( ( self.DWDividerLine.Right - ( 25 * rightClipPush ) ) ) - ( 5 * stockPush ) )

        local leftClipPush = ( #tostring( leftClip ) - 1 ) * 0.5

        self.WeaponAmmoDW:setLeftRight( false, true, ( ( self.WeaponAmmoDW.Left - ( 25 * rightClipPush ) - ( 1.5 * leftClipPush ) ) - ( 25 * stockPush ) ), ( self.WeaponAmmoDW.Right - ( 25 * rightClipPush ) ) )
    end

    self.WeaponStock:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInClip" ), UpdateStockAmmo )
    self.WeaponStock:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInDWClip" ), UpdateStockAmmo )
    self.WeaponStock:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoStock" ), UpdateStockAmmo )

    self.DPADWeaponParent.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self.DPADWeaponParent:setupElementClipCounter( 2 )
                
                self.WeaponAmmo:completeAnimation()
                self.WeaponAmmo:setAlpha( 1.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponAmmo, {} )

                --self.WeaponAmmoDW:completeAnimation()
                --self.WeaponAmmoDW:setAlpha( 1.0 )
                --self.DPADWeaponParent.clipFinished( self.WeaponAmmoDW, {} )

                --self.DWDividerLine:completeAnimation()
                --self.DWDividerLine:setAlpha( 1.0 )
                --self.DPADWeaponParent.clipFinished( self.DWDividerLine, {} )

                self.WeaponStock:completeAnimation()
                self.WeaponStock:setAlpha( 1.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponStock, {} )
            end
        },
        DoesNotUseAmmo = {
            DefaultClip = function()
                self.DPADWeaponParent:setupElementClipCounter( 2 )
                
                self.WeaponAmmo:completeAnimation()
                self.WeaponAmmo:setAlpha( 0.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponAmmo, {} )

                --self.WeaponAmmoDW:completeAnimation()
                --self.WeaponAmmoDW:setAlpha( 0.0 )
                --self.DPADWeaponParent.clipFinished( self.WeaponAmmoDW, {} )

                --self.DWDividerLine:completeAnimation()
                --self.DWDividerLine:setAlpha( 0.0 )
                --self.DPADWeaponParent.clipFinished( self.DWDividerLine, {} )

                self.WeaponStock:completeAnimation()
                self.WeaponStock:setAlpha( 0.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponStock, {} )
            end
        },
        DoesNotUseStockAmmo = {
            DefaultClip = function()
                self.DPADWeaponParent:setupElementClipCounter( 2 )
                
                self.WeaponAmmo:completeAnimation()
                self.WeaponAmmo:setAlpha( 1.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponAmmo, {} )

                --self.WeaponAmmoDW:completeAnimation()
                --self.WeaponAmmoDW:setAlpha( 1.0 )
                --self.DPADWeaponParent.clipFinished( self.WeaponAmmoDW, {} )

                --self.DWDividerLine:completeAnimation()
                --self.DWDividerLine:setAlpha( 1.0 )
                --self.DPADWeaponParent.clipFinished( self.DWDividerLine, {} )

                self.WeaponStock:completeAnimation()
                self.WeaponStock:setAlpha( 0.0 )
                self.DPADWeaponParent.clipFinished( self.WeaponStock, {} )
            end
        }
    }

    self.DPADWeaponParent.StateTable = {
        {
            stateName = "DoesNotUseAmmo",
            condition = function( menu, element, event )
                return ( not ( WeaponUsesAmmo( controller ) ) )
            end
        },
        {
            stateName = "DoesNotUseStockAmmo",
            condition = function( menu, element, event )
                return ( ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "elemental_bow" ) )
            end
        }
    }

    self.DPADWeaponParent:mergeStateConditions( self.DPADWeaponParent.StateTable )

    SubscribeToModelAndUpdateState( controller, menu, self.DPADWeaponParent, "CurrentWeapon.weapon" )
    SubscribeToModelAndUpdateState( controller, menu, self.DPADWeaponParent, "CurrentWeapon.viewmodelWeaponName" )

-- AAT Icon--------------------------------------------------------------------------------------------------------------

    local AATIcon = LUI.UIImage.new()
    AATIcon:setLeftRight( false, true, -2.5 - 29.5, -2.5 )
    AATIcon:setTopBottom( false, true, -125 - 29.5, -125 )
    AATIcon:setImage( RegisterImage( "blacktransparent" ) )
    AATIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.aatIcon" ), function ( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            AATIcon:setImage( RegisterImage( Engine.GetModelValue( ModelRef ) ) )
        end
    end )

    self.DPADWeaponParent:addElement( AATIcon )
    self.AATIcon = AATIcon

    local AATName = CoD.UIShadowText.new()
    AATName:setLeftRight( false, true, -15 - 100, -15 )
    AATName:setTopBottom( false, true, -112 - 62.5, -112 )
    AATName:setText( Engine.Localize( "" ) )
    AATName:setTTF( "fonts/morrissans.ttf" )
    AATName:setRGB( 1, 1, 1 )
    AATName:setAlpha( 0.75 )
    AATName:setScale( 0.3150 )

    AATName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.aatIcon" ), function ( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            if Engine.GetModelValue( ModelRef ) == "t7_icon_zm_aat_blast_furnace" then
                AATName:setText( Engine.Localize( "ZMUI_ZM_AAT_BLAST_FURNACE" ) )

            elseif Engine.GetModelValue( ModelRef ) == "t7_icon_zm_aat_dead_wire" then
                AATName:setText( Engine.Localize( "ZMUI_ZM_AAT_DEAD_WIRE" ) )

            elseif Engine.GetModelValue( ModelRef ) == "t7_icon_zm_aat_fire_works" then
                AATName:setText( Engine.Localize( "ZMUI_ZM_AAT_FIRE_WORKS" ) )

            elseif Engine.GetModelValue( ModelRef ) == "t7_icon_zm_aat_thunder_wall" then
                AATName:setText( Engine.Localize( "ZMUI_ZM_AAT_THUNDER_WALL" ) )

            elseif Engine.GetModelValue( ModelRef ) == "t7_icon_zm_aat_turned" then
                AATName:setText( Engine.Localize( "ZMUI_ZM_AAT_TURNED" ) )

            else
                AATName:setText( Engine.Localize( "" ) )
            end
        end
    end )

    self.DPADWeaponParent:addElement( AATName )
    self.AATName = AATName


-- grenades--------------------------------------------------------------------------------------------------------------

    local OffHandFragIcon = CoD.T5OffhandSlotsWidget.new( menu, controller )
    OffHandFragIcon:setLeftRight( false, true, -153, -126 )
    OffHandFragIcon:setTopBottom( false, true, -28.5, -1.5 )
    OffHandFragIcon:setAmmoModel( "currentPrimaryOffhand.primaryOffhandCount" )
    OffHandFragIcon:setIconModel( "currentPrimaryOffhand.primaryOffhand" )
    OffHandFragIcon:setAlpha( 0.65 )

    self.DPADParent:addElement( OffHandFragIcon )
    self.OffHandFragIcon = OffHandFragIcon

    local OffHandSmokeIcon = CoD.T5OffhandSlotsWidget.new( menu, controller )
    OffHandSmokeIcon:setLeftRight( false, true, -190.5, -163.5 )
    OffHandSmokeIcon:setTopBottom( false, true, -28.5, -1.5 )
    OffHandSmokeIcon:setAmmoModel( "currentSecondaryOffhand.secondaryOffhandCount" )
    OffHandSmokeIcon:setIconModel( "currentSecondaryOffhand.secondaryOffhand" )
    OffHandSmokeIcon:setAlpha( 0.65 )

    self.DPADParent:addElement( OffHandSmokeIcon )
    self.OffHandSmokeIcon = OffHandSmokeIcon

-- weapon name--------------------------------------------------------------------------------------------------------------

    local WeaponName = CoD.UIShadowText.new( menu, controller )
    WeaponName:setLeftRight( false, true, -25 - 300, -25 )
    WeaponName:setTopBottom( false, true, -43 - 62.5, -43 )
    WeaponName:setText( "" )
    WeaponName:setAlpha( 0.75 )
    WeaponName:setRGB( 1.0, 1.0, 1.0 )
    WeaponName.TextShadow:setRGB( 0.0, 0.0, 0.0 )
    WeaponName:setTTF( "fonts/morrissans.ttf" )
    WeaponName:setScale( 0.3150 )
    --WeaponName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
    
    self.DPADParent:addElement( WeaponName )
    self.WeaponName = WeaponName

    self.WeaponName:subscribeToGlobalModel( controller, "CurrentWeapon", "weaponName", function ( ModelRef )
        if Engine.GetModelValue( ModelRef ) then
            self.WeaponName:setText( Engine.Localize( Engine.GetModelValue( ModelRef ) ) )

            if IsModelValueTrue( controller, "hudItems.playerSpawned" ) then
                self.WeaponName:playClip( "FadeOut" )
            end
        end
    end)

    self.WeaponName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.playerSpawned" ), function ( ModelRef )
        menu:updateElementState( self.WeaponName, {
            name = "model_validation",
            menu = menu,
            modelValue = Engine.GetModelValue( ModelRef ),
            modelName = "hudItems.playerSpawned"
        } )
    end )

    self.WeaponName.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self.WeaponName:setupElementClipCounter( 2 )
                
                self.WeaponName.Text:completeAnimation()
                self.WeaponName.Text:setAlpha( 1.0 )
                self.WeaponName.clipFinished( self.WeaponName.Text, {} )

                self.WeaponName.TextShadow:completeAnimation()
                self.WeaponName.TextShadow:setAlpha( 1.0 )
                self.WeaponName.clipFinished( self.WeaponName.TextShadow, {} )
            end,
            FadeOut = function()
                self.WeaponName:setupElementClipCounter( 2 )

                self.WeaponName.Text:completeAnimation()
                self.WeaponName.Text:setAlpha( 1.0 )
                self.WeaponName.Text:beginAnimation( "keyframe", 1500, true, true, CoD.TweenType.Linear )
                self.WeaponName.Text:setAlpha( 1.0 )
                self.WeaponName.Text:beginAnimation( "keyframe", 2000, true, true, CoD.TweenType.Linear )
                self.WeaponName.Text:setAlpha( 0.0 )
                self.WeaponName.Text:registerEventHandler( "transition_complete_keyframe", function( Element, Event )
                    self.WeaponName.clipFinished( Element, Event )
                end)

                self.WeaponName.TextShadow:completeAnimation()
                self.WeaponName.TextShadow:setAlpha( 1.0 )
                self.WeaponName.TextShadow:beginAnimation( "keyframe", 2000, true, true, CoD.TweenType.Linear )
                self.WeaponName.TextShadow:setAlpha( 0.0 )
                self.WeaponName.TextShadow:registerEventHandler( "transition_complete_keyframe", function( Element, Event )
                    self.WeaponName.clipFinished( Element, Event )
                end)
            end
        }
    }

    local DPADReloadTextParent = LUI.UIElement.new()
    DPADReloadTextParent:setLeftRight( true, true, 0.0, 0.0 )
    DPADReloadTextParent:setTopBottom( true, false, 0.0, 19.0 )

    self.DPADParent:addElement( DPADReloadTextParent )
    self.DPADReloadTextParent = DPADReloadTextParent

    local WeaponReloadText = CoD.UIShadowText.new( menu, controller )
    WeaponReloadText:setLeftRight( false, false, -125, 125 )
    WeaponReloadText:setTopBottom( true, false, 0, 16 )
    WeaponReloadText:setText( "PLATFORM_RELOAD" )
    WeaponReloadText:setAlpha( 1.0 )
    WeaponReloadText:setRGB( 1.0, 1.0, 1.0 )
    WeaponReloadText:setTTF( "fonts/helveticaneue.ttf" )
    WeaponReloadText:setScale( 0.2750 )
    WeaponReloadText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    WeaponReloadText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_MIDDLE )

    self.DPADReloadTextParent:addElement( WeaponReloadText )
    self.WeaponReloadText = WeaponReloadText

    local function UpdateReloadText( ModelRef )
        local leftClip = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInDWClip" ) )
        local rightClip = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInClip" ) )
        local stock = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoStock" ) )
        local name = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.weaponName" ) )

        -- prevents knuckles and perks from having text pop up
        if not name or name == "" or ( not WeaponUsesAmmo( controller ) ) then
            self.WeaponReloadText.Text:setAlpha( 0.0 )
            self.WeaponReloadText.Text:setText( "" )
            self.WeaponReloadText.Text:setRGB( 1.0, 1.0, 1.0 )
            return
        end

        if not rightClip or not stock or not leftClip then
            return
        end

        -- 0 = none 1 = reload 2 = low ammo 3 = no ammo
        local type = 0

        if leftClip and leftClip > -1 then
            if IsLowAmmoClip( controller ) and IsLowAmmoDWClip( controller ) then
                if stock > 0 then
                    type = 1
                else
                    if rightClip == 0 and leftClip == 0 then
                        type = 3
                    else
                        type = 2
                    end
                end
            else
                if stock == 0 then
                    type = 2
                end
            end
        else
            if IsLowAmmoClip( controller ) then
                if stock > 0 then
                    type = 1
                else
                    if rightClip == 0 then
                        type = 3
                    else
                        type = 2
                    end
                end
            else
                if stock == 0 then
                    type = 2
                end
            end
        end

        if type == 0 then
            self.WeaponReloadText.Text:setAlpha( 0.0 )
            self.WeaponReloadText.Text:setText( "" )
            self.WeaponReloadText.Text:setRGB( 1.0, 1.0, 1.0 )
        elseif type == 1 then
            self.WeaponReloadText.Text:setAlpha( 1.0 )
            self.WeaponReloadText.Text:setText( Engine.Localize( "PLATFORM_RELOAD" ) )
            self.WeaponReloadText.Text:setRGB( 1.0, 1.0, 1.0 )
        elseif type == 2 then
            self.WeaponReloadText.Text:setAlpha( 1.0 )
            self.WeaponReloadText.Text:setText( Engine.Localize( "PLATFORM_LOW_AMMO_NO_RELOAD" ) )
            self.WeaponReloadText.Text:setRGB( 1.0, 1.0, 0.3 )
        else
            self.WeaponReloadText.Text:setAlpha( 1.0 )
            self.WeaponReloadText.Text:setText( Engine.Localize( "WEAPON_NO_AMMO" ) )
            self.WeaponReloadText.Text:setRGB( 0.7, 0.05, 0.05 )
        end
    end

    self.WeaponReloadText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInClip" ), UpdateReloadText )
    self.WeaponReloadText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoInDWClip" ), UpdateReloadText )
    self.WeaponReloadText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.ammoStock" ), UpdateReloadText )
    self.WeaponReloadText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.weapon" ), UpdateReloadText )
    self.WeaponReloadText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.equippedWeaponReference" ), UpdateReloadText )


-- DPAD--------------------------------------------------------------------------------------------------------------

    local DPADContainer = CoD.T5AmmoDPADWidget.new( menu, controller )
    DPADContainer:setLeftRight( true, true, 0, 0 )
    DPADContainer:setTopBottom( true, true, 0, 0 )

    self.DPADParent:addElement( DPADContainer )
    self.DPADContainer = DPADContainer

-- widget clip and callback--------------------------------------------------------------------------------------------------------------

    self.StateTable = {
        {
            stateName = "Hidden",
            condition = function( menu, element, event )
                return Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ) or
                       Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
            end
        }
    }

    self:mergeStateConditions( self.StateTable )

    self.clipsPerState = {
        DefaultState = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                self.ScaleContainer:completeAnimation()
                self.ScaleContainer:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear)
                self.ScaleContainer:setAlpha( 1 )
                self.ScaleContainer:registerEventHandler( "transition_complete_keyframe", function(Element, Event)
                    self.clipFinished(Element, Event)
                end)
            end
        },
        Hidden = {
            DefaultClip = function()
                self:setupElementClipCounter( 1 )

                self.ScaleContainer:completeAnimation()
                self.ScaleContainer:beginAnimation( "keyframe", 75, false, false, CoD.TweenType.Linear)
                self.ScaleContainer:setAlpha( 0 )
                self.ScaleContainer:registerEventHandler( "transition_complete_keyframe", function(Element, Event)
                    self.clipFinished(Element, Event)
                end)
            end
        }
    }
    
    SubscribeToModelAndUpdateState( controller, menu, self, "hudItems.playerSpawned" )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE )
    SubscribeToModelAndUpdateState( controller, menu, self, "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
        element.BloodSplat:close()
        element.DPADLinesFade:close()
        element.DPADLines:close()
        element.DPADWeaponParent:close()
        element.WeaponAmmo:close()
        element.DWDividerLine:close()
        element.WeaponAmmoDW:close()
        element.WeaponStock:close()
        element.OffHandFragIcon:close()
        element.OffHandSmokeIcon:close()
        element.WeaponName:close()
        element.WeaponReloadText:close()
        element.AATIcon:close()
        element.AATName:close()
        element.DPADContainer:close()

    end)

    return self
end