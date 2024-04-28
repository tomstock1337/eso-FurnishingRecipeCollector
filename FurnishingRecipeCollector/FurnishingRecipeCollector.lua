local FurnishingRecipeCollector = {}
FurnishingRecipeCollector.Name = "FurnishingRecipeCollector"
FurnishingRecipeCollector.DisplayName = "FurnishingRecipeCollector"
FurnishingRecipeCollector.Author = "tomstock"
FurnishingRecipeCollector.Version = "1.0"

FurnishingRecipeCollector.Debug = false --Todo: Change that to false before setting live, or else tooltips will contain an extra ID row at the end
FurnishingRecipeCollector.logger = nil

--------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------
--ZOs local speed-up/reference variables
local EM = EVENT_MANAGER
local SNM = SCREEN_NARRATION_MANAGER
local tos = tostring
local sfor = string.format
local tins = table.insert

--[[
  ==============================================
  Setup LibDebugLogger as an optional dependency
  ==============================================
--]]
if LibDebugLogger and FurnishingRecipeCollector.Debug then
  FurnishingRecipeCollector.logger = LibDebugLogger.Create(FurnishingRecipeCollector.Name)
  FurnishingRecipeCollector.logger:Info("Loaded logger")
end

local function adjustToolTip(tooltipControl, method, itemLink)
  FurnishingRecipeCollector.logger:Info(tos(itemLink))

  ZO_Tooltip_AddDivider(tooltipControl)
  tooltipControl:AddLine("Hello world")
end
local function TooltipHook(tooltipControl, method, linkFunc)
	local origMethod = tooltipControl[method]

	tooltipControl[method] = function(self, ...)
		origMethod(self, ...)

    adjustToolTip(tooltipControl, method, linkFunc(...))
	end
end

local function TooltipHook_Gamepad(tooltipControl, method, linkFunc)
	local origMethod = tooltipControl[method]

	tooltipControl[method] = function(self, ...)
		local result = origMethod(self, ...)

    adjustToolTip(tooltipControl, method, linkFunc(...))

    return result
	end
end

local function HookTooltips()
	TooltipHook(ItemTooltip, "SetBagItem", GetItemLink)
	TooltipHook(ItemTooltip, "SetTradeItem", GetTradeItemLink)
	TooltipHook(ItemTooltip, "SetBuybackItem", GetBuybackItemLink)
	TooltipHook(ItemTooltip, "SetStoreItem", GetStoreItemLink)
	TooltipHook(ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink)
	TooltipHook(ItemTooltip, "SetLootItem", GetLootItemLink)
	TooltipHook(ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink)
	TooltipHook(ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink)
	TooltipHook(ItemTooltip, "SetLink", ReturnItemLink)

	TooltipHook(PopupTooltip, "SetLink", ReturnItemLink)

	TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_LEFT_TOOLTIP), "LayoutItem", ReturnItemLink)
	TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_RIGHT_TOOLTIP), "LayoutItem", ReturnItemLink)
	TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_MOVABLE_TOOLTIP), "LayoutItem", ReturnItemLink)
end

--[[
  ==============================================
  Plugin Initialization - cache titles where possible, recreate when necessary
  ==============================================
--]]
local function OnLoad(eventCode, name)

  if name ~= FurnishingRecipeCollector.Name then return end
  HookTooltips()

  EVENT_MANAGER:UnregisterForEvent(FurnishingRecipeCollector.Name, EVENT_ADD_ON_LOADED)

end

--[[
  ==============================================
  AddOn global and loading
  ==============================================
--]]
FURNISHINGRECIPECOLLECTOR = FurnishingRecipeCollector
EVENT_MANAGER:RegisterForEvent(FurnishingRecipeCollector.Name, EVENT_ADD_ON_LOADED, OnLoad)