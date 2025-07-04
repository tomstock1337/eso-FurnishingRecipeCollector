-- If we overwrite this method directly, this error does not happen in gamepad.
--[[
bad argument #2 to 'math.max' (number expected, got nil)
|rstack traceback:
[C]: in function 'math.max'
EsoUI/Libraries/ZO_Tooltip/ZO_Tooltip.lua:742: in function 'ZO_TooltipSection:AddControl'
|caaaaaa<Locals> self = ud, control = ud, spacing = 0 </Locals>|r
(tail call): ?
EsoUI/Libraries/ZO_Templates/Tooltip.lua:276: in function 'ZO_Tooltip_AddDivider'
|caaaaaa<Locals> tooltipControl = ud, divider = ud </Locals>|r
user:/AddOns/FurnishingRecipeCollector/FRC_ToolTip.lua:50: in function 'adjustToolTip'
|caaaaaa<Locals> tooltipControl = ud, itemLink = "|H0:item:211039:0:0:0:0:0:0:0:...", fontStyle = "MEDIUM_FONT", fontSizeH1 = 14, fontSizeH2 = 12, fontWeight = "soft-shadow-thin", vItemLinkId = 211039, vItemName = "Blueprint: Colovian Keg, Gigan...", vItemFunctionalQuality = 5, vItemType = 29, vSpecialType = 177, vRecipeItemLinkId = 211039, vRecipeItemLink = "|H1:item:211039:1:1:0:0:0:0:0:...", vRecipeItemName = "Blueprint: Colovian Keg, Gigan...", vLocation = "Faustina Curio Writ Vendor", vResultLinkId = 208121, vResultLink = "|H0:item:208121:6:1:0:0:0:0:0:...", vResultName = "Colovian Keg, Gigantic Wine", vRecipePrice = 191666.7, vRecipeListing = 3 </Locals>|r
user:/AddOns/FurnishingRecipeCollector/FRC_ToolTip.lua:131: in function '(anonymous)'
|caaaaaa<Locals> self = ud, result = T </Locals>|r
(tail call): ?
(tail call): ?
EsoUI/PublicAllIngames/Tooltip/ItemTooltips.lua:1549: in function 'ZO_Tooltip:LayoutStoreItemFromLink'
|caaaaaa<Locals> self = ud, itemLink = "|H0:item:211039:0:0:0:0:0:0:0:...", icon = "/esoui/art/icons/crafting_plan...", stackCount = 1 </Locals>|r
EsoUI/PublicAllIngames/Tooltip/ItemTooltips.lua:1561: in function 'ZO_Tooltip:LayoutStoreWindowItem'
|caaaaaa<Locals> self = ud, itemData = [table:1]{enabled = T, numIcons = 1, showBarEvenWhenUnselected = T, text = "Blueprint: Colovian Keg, Gigan...", cooldownIcon = "/esoui/art/icons/crafting_plan...", meetsUsageRequirement = T, alphaChangeOnSelection = F, narrationPrice = 100, narrationCurrencyType = 4, subLabelTemplate = "ZO_GamepadMenuEntrySubLabelTem...", header = "Consumable", ignoreTraitInformation = T, currencyType1 = 4, fontScaleOnSelection = F} </Locals>|r
EsoUI/Common/ZO_Tooltip/Gamepad/ZO_Tooltip_Gamepad.lua:32: in function 'LayoutFunction'
|caaaaaa<Locals> self = [table:2]{currentLayoutFunctionName = "LayoutStoreWindowItem"}, tooltipType = "GAMEPAD_LEFT_TOOLTIP", tooltipContainer = ud, tooltipContainerTip = ud, tooltipFunction = EsoUI/PublicAllIngames/Tooltip/ItemTooltips.lua:1553, tooltipInfo = [table:3]{defaultAutoShowBg = T, autoShowBg = T, scrollIndicatorSide = 8, resetScroll = T, bgType = 1} </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindowBuy_Gamepad.lua:208: in function 'ZO_GamepadStoreBuy:OnSelectedItemChanged'
|caaaaaa<Locals> self = [table:4]{tabText = "Buy", storeMode = 1, searchContext = "storeTextSearch"}, buyData = [table:1] </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindowComponent_Gamepad.lua:157: in function 'onActivatedChangedFunction'
|caaaaaa<Locals> currentList = [table:5]{anchorOppositeSide = F, lastContinousTargetOffset = 1, template = "ZO_GamepadPricedVendorItemEntr...", searchContext = "storeTextSearch", universalPostPadding = 16, validGradientDirty = T, headerDefaultPadding = 80, enabled = T, active = T, handleDynamicViewProperties = F, selectedIndex = 1, fireCallbackDepth = 0, directionalInputEnabled = F, alignToScreenCenter = T, additonalMaxBottomOffset = 0, alignToScreenCenterExpectedEntryHalfHeight = 25, minOffset = 0, isMoving = F, universalPrePadding = 0, targetSelectedIndex = 1, storeMode = 1, mode = T, jumping = F, additonalMinBottomOffset = 0, animationEnabled = T, centerDampingFactor = 0, defaultSelectedIndex = 1, fixedCenterOffset = 0, reselectBehavior = 3, maxOffset = 40, soundEnabled = T, headerSelectedPadding = -40}, activated = T </Locals>|r
EsoUI/Libraries/ZO_ParametricScrollList/ZO_ParametricScrollList.lua:402: in function 'ZO_ParametricScrollList:SetActive'
|caaaaaa<Locals> self = [table:5], active = T </Locals>|r
EsoUI/Libraries/ZO_ParametricScrollList/ZO_ParametricScrollList.lua:421: in function 'ZO_ParametricScrollList:Activate'
|caaaaaa<Locals> self = [table:5] </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindowComponent_Gamepad.lua:165: in function '(anonymous)'
[C]: in function 'SetHidden'
EsoUI/Libraries/ZO_Scene/ZO_SceneFragmentTemplates.lua:505: in function 'ZO_ConveyorSceneFragment:Show'
|caaaaaa<Locals> self = [table:6]{outAnimation = "ConveyorOutSceneAnimation", fireCallbackDepth = 0, animationKey = 1, alwaysAnimate = T, state = "showing", inAnimation = "ConveyorInSceneAnimation", currentAnimationTemplate = "ConveyorInSceneAnimation", allowShowHideTimeUpdates = F} </Locals>|r
EsoUI/Libraries/ZO_Scene/ZO_SceneFragment.lua:163: in function 'ZO_SceneFragment:ShouldBeShown'
|caaaaaa<Locals> self = [table:6] </Locals>|r
EsoUI/Libraries/ZO_Scene/ZO_SceneFragment.lua:233: in function 'ZO_SceneFragment:Refresh'
|caaaaaa<Locals> self = [table:6], oldState = "hidden" </Locals>|r
EsoUI/Libraries/ZO_Scene/ZO_Scene.lua:44: in function 'ZO_Scene:AddFragment'
|caaaaaa<Locals> self = [table:7]{restoresHUDSceneToggleGameMenu = F, name = "gamepad_store", restoresHUDSceneToggleUIMode = F, wasRequestedToShowInGamepadPreferredMode = T, state = "shown", fireCallbackDepth = 1, wasShownInGamepadPreferredMode = T, disallowEvaluateTransitionCompleteCount = 1}, fragment = [table:6] </Locals>|r
EsoUI/Libraries/ZO_Scene/ZO_Scene.lua:81: in function 'ZO_Scene:AddTemporaryFragment'
|caaaaaa<Locals> self = [table:7], fragment = [table:6] </Locals>|r
EsoUI/Libraries/ZO_Scene/ZO_SceneManager_Base.lua:113: in function 'ZO_SceneManager_Base:AddFragment'
|caaaaaa<Locals> self = [table:8]{exitUIModeOnChatFocusLost = F, isLoadingScreenShown = F, initialized = F, fireCallbackDepth = 0, hudUISceneHidesAutomatically = T, remoteSceneSequenceNumber = 7, hudSceneName = "hud", numRemoteTopLevelShown = 0, numTopLevelShown = 0, hudUISceneName = "hudui"}, fragment = [table:6], state = "shown" </Locals>|r
EsoUI/Common/Gamepad/ZO_GamepadParametricScrollListScreen.lua:147: in function 'ZO_Gamepad_ParametricList_Screen:EnableCurrentList'
|caaaaaa<Locals> self = [table:9]{dirty = T, activateOnShow = F, sceneName = "gamepad_store", searchContext = "storeTextSearch", addListTriggerKeybinds = F, searchFilterType = 1, updateCooldownMS = 0}, currentFragment = [table:6] </Locals>|r
EsoUI/Common/Gamepad/ZO_GamepadParametricScrollListScreen.lua:173: in function 'ZO_Gamepad_ParametricList_Screen:SetCurrentList'
|caaaaaa<Locals> self = [table:9], list = [table:5] </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindow_Gamepad.lua:357: in function 'ZO_GamepadStoreManager:ShowComponent'
|caaaaaa<Locals> self = [table:9], component = [table:4] </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindow_Gamepad.lua:321: in function 'OnActivatedChanged'
|caaaaaa<Locals> list = [table:10]{enabled = T, lastContinousTargetOffset = 1, headerDefaultPadding = 80, pipsEnabled = T, validGradientDirty = T, handleDynamicViewProperties = F, active = T, jumping = F, directionalInputEnabled = F, universalPrePadding = 0, fireCallbackDepth = 0, additonalMaxBottomOffset = 0, additonalMinBottomOffset = 0, selectedIndex = 1, minOffset = 0, isMoving = F, targetSelectedIndex = 1, animationEnabled = F, universalPostPadding = 0, hideUnselectedControls = T, anchorOppositeSide = F, fixedCenterOffset = 0, centerDampingFactor = 0, defaultSelectedIndex = 1, mode = F, reselectBehavior = 3, headerSelectedPadding = -40, maxOffset = 40, soundEnabled = T}, activated = T, component = [table:4] </Locals>|r
EsoUI/Ingame/StoreWindow/Gamepad/StoreWindow_Gamepad.lua:347: in function 'onActivatedChangedFunction'
EsoUI/Libraries/ZO_ParametricScrollList/ZO_ParametricScrollList.lua:402: in function 'ZO_ParametricScrollList:SetActive'
|caaaaaa<Locals> self = [table:10], active = T </Locals>|r
EsoUI/Libraries/ZO_ParametricScrollList/ZO_ParametricScrollList.lua:421: in function 'ZO_ParametricScrollList:Activate'
|caaaaaa<Locals> self = [table:10] </Locals>|r
]]
function ZO_TooltipSection:AddControl(control, primarySize, secondarySize, ...)
    primarySize = primarySize or 0
	secondarySize = secondarySize or 0

    control:SetParent(self.contentsControl)
    control:ClearAnchors()

    local spacing = self:GetNextSpacing(...)
    if self:ShouldAdvanceSecondaryCursor(primarySize, spacing) then
        local advanceAmount = self.maxSecondarySizeOnLine + (self:GetProperty("childSecondarySpacing") or 0)
        self.secondaryCursor = self.secondaryCursor + advanceAmount
        if not self:IsSecondaryDimensionFixed() then
            self:AddToSecondaryDimension(advanceAmount)
        end
        self.maxSecondarySizeOnLine = 0
        self.primaryCursor = 0
        self.firstInLine = true
        spacing = self:GetNextSpacing(...)

        --If we are not vertical, the secondary cursor direction is either up or down, so advancing the secondary cursor means we added a new row
        if not self:IsVertical() then
            if self.secondaryCursorDirection == -1 then
                --If the direction is up, then we need to insert the new row at the front
                table.insert(self.narrationText, 1, {})
                self.currentRow = 1
            else
                --If the direction is down, then we need to insert the new row at the end
                table.insert(self.narrationText, {})
                self.currentRow = self.currentRow + 1
            end
        end
    end
    self.primaryCursor = self.primaryCursor + spacing
    self.maxSecondarySizeOnLine = zo_max(self.maxSecondarySizeOnLine, secondarySize)
    if not self:IsSecondaryDimensionFixed() then
        if self:IsVertical() then
            self:SetSecondaryDimension(self.maxSecondarySizeOnLine + self.secondaryCursor + self.paddingLeft + self.paddingRight)
        else
            self:SetSecondaryDimension(self.maxSecondarySizeOnLine + self.secondaryCursor + self.paddingTop + self.paddingBottom)
        end
    end

    if self:IsVertical() then
        control.offsetX = self.secondaryCursor * self.secondaryCursorDirection
        control.offsetY = self.primaryCursor * self.primaryCursorDirection
        --If we are vertical, then our primary cursor direction is either up or down
        if self.primaryCursorDirection == -1 then
            --If the direction is up, then we need to insert the new row at the front
            table.insert(self.narrationText, 1, {})
            self.currentRow = 1
        else
            --If the direction is down, then we need to insert the new row at the end
            table.insert(self.narrationText, {})
            self.currentRow = self.currentRow + 1
        end
    else
        control.offsetX = self.primaryCursor * self.primaryCursorDirection
        control.offsetY = self.secondaryCursor * self.secondaryCursorDirection
    end

    if not self.isPrimaryDimensionCentered then
        control:SetAnchor(self.layoutRootAnchor, nil, self.layoutRootAnchor, control.offsetX, control.offsetY)
    end

    if not self:IsPrimaryDimensionFixed() then
        self:AddToPrimaryDimension(primarySize + spacing)
    end

    self.primaryCursor = self.primaryCursor + primarySize
    self.numControls = self.numControls + 1
    self.firstInLine = false

    if self.isPrimaryDimensionCentered then
        local centerOffsetPrimary = ((self.innerPrimaryDimension - self.primaryCursor) / 2) * self.primaryCursorDirection
        local numChildren = self.contentsControl:GetNumChildren()
        for i = 1, numChildren do
            local childControl = self.contentsControl:GetChild(i)
            local childSecondaryOffset = self:IsVertical() and childControl.offsetX or childControl.offsetY
            if childSecondaryOffset == self.secondaryCursor then
                local modifiedOffsetX = childControl.offsetX + (self:IsVertical() and 0 or centerOffsetPrimary)
                local modifiedOffsetY = childControl.offsetY + (self:IsVertical() and centerOffsetPrimary or 0)
                childControl:SetAnchor(self.layoutRootAnchor, nil, self.layoutRootAnchor, modifiedOffsetX, modifiedOffsetY)
            end
        end
    end

    self:AddNextNarrationText()
end