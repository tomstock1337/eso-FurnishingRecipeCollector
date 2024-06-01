FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector
FRC.Name = "FurnishingRecipeCollector"
FRC.DisplayName = "FurnishingRecipeCollector"
FRC.Author = "tomstock"
FRC.Version = "1.2"

FRC.logger = nil

FRC.defaultSetting = {
  debug = true,
  furnishing_on = true,
  furnishing_showrecipe_on = true,
  furnishing_showrecipe_ttc_on = true,
  furnishing_showrecipe_lck_on = true,
  furnishingrecipe_on = true,
  grabbag_on= true,
  grabbag_lck_on= true,
  folio_on= true,
  folio_lck_on= true,
  gui={
    lastX = 100,
    lastY = 100,
    width = 650,
    height = 550,
  }
}

--------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------
--ZOs local speed-up/reference variables
local tos = tostring
local LCK = LibCharacterKnowledge
local SLASH = LibSlashCommander

--[[
  ==============================================
  Setup LibDebugLogger as an optional dependency
  ==============================================
--]]
if LibDebugLogger then
  FRC.logger = LibDebugLogger.Create(FRC.Name)
  FRC.logger:SetEnabled(false)
end
if LCK ~= nil then
  FRC.Colors = {
    [LCK.KNOWLEDGE_KNOWN] = 0x3399FF,
    [LCK.KNOWLEDGE_UNKNOWN] = 0x777766,
  }
  FRC.Style = {
    fontSize=12,
  }
end



local function adjustToolTip(tooltipControl, itemLink)
  local fontStyle = "MEDIUM_FONT"
  local fontSizeH1 = 14
  local fontSizeH2 = 12
  local fontWeight = "soft-shadow-thin"
  local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(itemLink)


  if vFolioItemLinkId ~= nil or vRecipeItemLinkId ~= nil or vGrabBagItemLinkId ~= nil then
    if FRC.logger ~= nil then FRC.logger:Info(" ItemName:"..vItemName.."LinkID: "..tos(vItemLinkId).." ItemType: "..tos(vItemType).." SpType: "..tos(vSpecialType).." Recipe: "..tos(vRecipeItemLinkId).." Folio: "..tos(vFolioItemLinkId).." GrabBag: "..tos(vGrabBagItemLinkId).." RecipeName: "..tos(vRecipeItemName)) end

    if vRecipeItemLinkId ~= nil and (vGrabBagItemLinkId ~= nil or vFolioItemLinkId ~= nil) then
      --Recipe or Furnishing from a folio or grab bag

      if vItemType == ITEMTYPE_FURNISHING and FRC.savedVariables.furnishing_on == false then
        return
      elseif vItemType ~= ITEMTYPE_FURNISHING and FRC.savedVariables.furnishingrecipe_on == false then
        return
      end

      local vCharacterString, vRecipeCount = FRC.GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)

      tooltipControl:AddLine("Recipe available in Writ Vendor Folio: ",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      tooltipControl:AddLine((vFolioItemLink or vGrabBagItemLink),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))

      if LCK ~= nil then
        tooltipControl:AddLine("Folio Knowledge: "..vCharacterString,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      else
        tooltipControl:AddLine("Recipe Count: "..vRecipeCount,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      end
      if vItemType == ITEMTYPE_FURNISHING and FRC.savedVariables.furnishing_showrecipe_on  then
        --only add recipe details to furnishings
        ZO_Tooltip_AddDivider(tooltipControl)
        tooltipControl:AddLine(vRecipeItemLink,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        if LCK ~= nil and FRC.savedVariables.furnishing_showrecipe_lck_on then
          local chars= LCK.GetItemKnowledgeList(vRecipeItemLinkId,nil,nil)
          local characterstring = ""
          local knownCount = 0

          for i, char in ipairs(chars) do
            -- if FRC.logger ~= nil then FRC.logger:Verbose(tos(char["name"]).." "..tos(char["knowledge"])) end
            if char.knowledge == LCK.KNOWLEDGE_KNOWN or char.knowledge == LCK.KNOWLEDGE_UNKNOWN then
              if char.knowledge == LCK.KNOWLEDGE_KNOWN then knownCount = knownCount + 1 end
              if characterstring ~= "" then
                characterstring = characterstring..", "
              end
              characterstring = characterstring..string.format("|c%06X%s|r", FRC.Colors[char.knowledge], char["name"])
            end
          end
          tooltipControl:AddLine("Known By "..knownCount.."/"..table.getn(chars)..": "..characterstring,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        end
        if TamrielTradeCentrePrice~= nil and ((vItemType == ITEMTYPE_FURNISHING and FRC.savedVariables.furnishing_showrecipe_ttc_on)) then
          local priceDetail = TamrielTradeCentrePrice:GetPriceInfo(vRecipeItemLink)
          if(priceDetail~=nil) then
            tooltipControl:AddLine("Average Price: "..zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(priceDetail["Avg"])),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
            tooltipControl:AddLine("Listings: "..priceDetail["EntryCount"],string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
          end
        end
      end
    elseif vRecipeItemLinkId ~= nil and vLocation ~= nil then
      ZO_Tooltip_AddDivider(tooltipControl)
      tooltipControl:AddLine("Recipe available from: "..vLocation,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      if vItemType == ITEMTYPE_FURNISHING and FRC.savedVariables.furnishing_showrecipe_on  then
        --only add recipe details to furnishings
        ZO_Tooltip_AddDivider(tooltipControl)
        tooltipControl:AddLine(vRecipeItemLink,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        if LCK ~= nil and FRC.savedVariables.furnishing_showrecipe_lck_on then
          local chars= LCK.GetItemKnowledgeList(vRecipeItemLinkId,nil,nil)
          local characterstring = ""
          local knownCount = 0

          for i, char in ipairs(chars) do
            -- if FRC.logger ~= nil then FRC.logger:Verbose(tos(char["name"]).." "..tos(char["knowledge"])) end
            if char.knowledge == LCK.KNOWLEDGE_KNOWN or char.knowledge == LCK.KNOWLEDGE_UNKNOWN then
              if char.knowledge == LCK.KNOWLEDGE_KNOWN then knownCount = knownCount + 1 end
              if characterstring ~= "" then
                characterstring = characterstring..", "
              end
              characterstring = characterstring..string.format("|c%06X%s|r", FRC.Colors[char.knowledge], char["name"])
            end
          end
          tooltipControl:AddLine("Known By "..knownCount.."/"..table.getn(chars)..": "..characterstring,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        end
        if TamrielTradeCentrePrice~= nil and ((vItemType == ITEMTYPE_FURNISHING and FRC.savedVariables.furnishing_showrecipe_ttc_on)) then
          local priceDetail = TamrielTradeCentrePrice:GetPriceInfo(vRecipeItemLink)
          if(priceDetail~=nil) then
            tooltipControl:AddLine("Average Price: "..zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(priceDetail["Avg"])),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
            tooltipControl:AddLine("Listings: "..priceDetail["EntryCount"],string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
          end
        end
      end
    elseif vGrabBagItemLinkId ~= nil then
      --Grab Bag
      if FRC.savedVariables.grabbag_on == false then
        return
      end

      local vCharacterString, vRecipeCount = FRC.GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)

      tooltipControl:AddLine("Recipe available in Writ Vendor Folio: ",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      tooltipControl:AddLine((vFolioItemLink or vGrabBagItemLink),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      if LCK ~= nil and FRC.savedVariables.grabbag_lck_on then
        tooltipControl:AddLine("Folio Knowledge: "..vCharacterString,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      else
        tooltipControl:AddLine("Recipe Count: "..vRecipeCount,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      end
    elseif vFolioItemLinkId ~= nil then
      --Folio
      if FRC.savedVariables.folio_on == false then
        return
      end

      local vCharacterString, vRecipeCount = FRC.GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)
      for i,recipeId in ipairs(FRC.Data.Folios[vItemLinkId]) do
        tooltipControl:AddLine("|H1:item:"..recipeId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        if LCK ~= nil and FRC.savedVariables.folio_lck_on then
          local charKnowledge = LCK.GetItemKnowledgeList( recipeId )
          if charKnowledge ~= nil then
            local characterstring = ""
              for i, knowledge in ipairs(charKnowledge) do
                -- if FRC.logger ~= nil then FRC.logger:Verbose(tos(knowledge["name"]).." "..tos(knowledge["knowledge"])) end

                if knowledge.knowledge == LCK.KNOWLEDGE_KNOWN or knowledge.knowledge == LCK.KNOWLEDGE_UNKNOWN then

                  if characterstring ~= "" then
                    characterstring = characterstring..", "
                  end
                  characterstring = characterstring..string.format("|c%06X%s|r", FRC.Colors[knowledge.knowledge], knowledge["name"])
                end
              end
              tooltipControl:AddLine("Known By: "..characterstring,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH2, fontWeight))
          end
        end
      end
      ZO_Tooltip_AddDivider(tooltipControl)
      if LCK ~= nil and FRC.savedVariables.folio_lck_on then
        tooltipControl:AddLine("Folio Knowledge: "..vCharacterString,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      else
        tooltipControl:AddLine("Recipe Count: "..vRecipeCount,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      end
    end
  end
end
local function TooltipHook(tooltipControl, method, linkFunc)
  local origMethod = tooltipControl[method]
  tooltipControl[method] = function(self, ...)
    origMethod(self, ...)

    adjustToolTip(tooltipControl, linkFunc(...))
  end
end

local function TooltipHook_Gamepad(tooltipControl, method, linkFunc)
  local origMethod = tooltipControl[method]

  tooltipControl[method] = function(self, ...)
    local result = origMethod(self, ...)

    adjustToolTip(tooltipControl, linkFunc(...))

    return result
  end
end
local ItemLinkPassthrough = function( itemLink )
  return itemLink
end
local function HookTooltips()

  TooltipHook(PopupTooltip, "SetLink", ItemLinkPassthrough)
  TooltipHook(ItemTooltip, "SetLink", ItemLinkPassthrough)
  TooltipHook(ItemTooltip, "SetBagItem", GetItemLink)
  TooltipHook(ItemTooltip, "SetTradeItem", GetTradeItemLink)
  TooltipHook(ItemTooltip, "SetBuybackItem", GetBuybackItemLink)
  TooltipHook(ItemTooltip, "SetStoreItem", GetStoreItemLink)
  TooltipHook(ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink)
  TooltipHook(ItemTooltip, "SetLootItem", GetLootItemLink)
  TooltipHook(ItemTooltip, "SetReward", GetItemRewardItemLink)
  TooltipHook(ItemTooltip, "SetQuestReward", GetQuestRewardItemLink)
  TooltipHook(ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink)
  TooltipHook(ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink)

  TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_LEFT_TOOLTIP), "LayoutItem", ItemLinkPassthrough)
  TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_RIGHT_TOOLTIP), "LayoutItem", ItemLinkPassthrough)
  TooltipHook_Gamepad(GAMEPAD_TOOLTIPS:GetTooltip(GAMEPAD_MOVABLE_TOOLTIP), "LayoutItem", ItemLinkPassthrough)
end

--[[
  ==============================================
  Plugin Initialization - cache titles where possible, recreate when necessary
  ==============================================
--]]
local function OnLoad(eventCode, name)

  if name ~= FRC.Name then return end
  EVENT_MANAGER:UnregisterForEvent(FRC.Name, EVENT_ADD_ON_LOADED)

  FRC.savedVariables = ZO_SavedVars:NewAccountWide("FurnishingRecipeCollectorSavedVariables", 1, nil, FRC.defaultSetting) --Instead of nil you can also use GetWorldName() to save the SV server dependent

  if FRC.logger ~= nil then
    FRC.logger:Info("Loaded logger")
    FRC.logger:SetEnabled(FRC.savedVariables.debug)
  end

  HookTooltips()

  local menuOptions = {
    type         = "panel",
    name         = FRC.Name,
    displayName   = FRC.DisplayName,
    author       = FRC.Author,
    version       = FRC.Version,
    registerForRefresh  = true,
    registerForDefaults = true,
  }

  local dataTable = {
    {
      type = "description",
      text = "Displays additional information in tooltips for furnshing recipes obtained through Writ vendors. ",
    },
    {
      type = "description",
      text = "Character Knowledge requires the LibCharacterKnowledge library to be installed or Character Knowledge addon installed.",
    },
    {
      type = "description",
      text = "Debug requires the LibDebugLogger library to be installed",
    },
    {
      type = "description",
      text = "Prices require the TamrielTradeCentre addon to be installed",
    },
    {
      type = "divider",
    },
    {
      type = "checkbox",
      name = "Show Debug",
      getFunc = function() return FRC.savedVariables.debug end,
      setFunc = function( newValue )
          FRC.savedVariables.debug = newValue;
          FRC.logger:SetEnabled(FRC.savedVariables.debug)
        end,
      --[[warning = "",]]
      requiresReload = false,
      default = FRC.DefDebug,},
    {
      type = "divider",
    },
    {type = "checkbox",name = "Show on Furnishings",getFunc = function() return FRC.savedVariables.furnishing_on end,setFunc = function( newValue ) FRC.savedVariables.furnishing_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {type = "checkbox",name = "Show Recipe",getFunc = function() return FRC.savedVariables.furnishing_showrecipe_on end,setFunc = function( newValue ) FRC.savedVariables.furnishing_showrecipe_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {type = "checkbox",name = "Show Recipe TTC Value",getFunc = function() return FRC.savedVariables.furnishing_showrecipe_ttc_on end,setFunc = function( newValue ) FRC.savedVariables.furnishing_showrecipe_ttc_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {type = "checkbox",name = "Show Recipe Character Knowledge",getFunc = function() return FRC.savedVariables.furnishing_showrecipe_lck_on end,setFunc = function( newValue ) FRC.savedVariables.furnishing_showrecipe_lck_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {
      type = "divider",
    },
    {type = "checkbox",name = "Show on Furnishing Recipes",getFunc = function() return FRC.savedVariables.furnishingrecipe_on end,setFunc = function( newValue ) FRC.savedVariables.furnishingrecipe_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {
      type = "divider",
    },
    {type = "checkbox",name = "Show on Writ Vendor Grab Bags",getFunc = function() return FRC.savedVariables.grabbag_on end,setFunc = function( newValue ) FRC.savedVariables.grabbag_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {type = "checkbox",name = "Show Character Knowledge",getFunc = function() return FRC.savedVariables.grabbag_lck_on end,setFunc = function( newValue ) FRC.savedVariables.grabbag_lck_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {
      type = "divider",
    },
    {type = "checkbox",name = "Show on Writ Vendor Folios",getFunc = function() return FRC.savedVariables.folio_on end,setFunc = function( newValue ) FRC.savedVariables.folio_on = newValue; end,--[[warning = "",]]  requiresReload = false},
    {type = "checkbox",name = "Show Character Knowledge",getFunc = function() return FRC.savedVariables.folio_lck_on end,setFunc = function( newValue ) FRC.savedVariables.folio_lck_on = newValue; end,--[[warning = "",]]  requiresReload = false},
  }
  LAM = LibAddonMenu2
  LAM:RegisterAddonPanel(FRC.Name .. "Options", menuOptions )
  LAM:RegisterOptionControls(FRC.Name .. "Options", dataTable )

  FRC.InitGui()

  if SLASH ~= nil then
    local command = SLASH:Register()
    command:AddAlias("/furrecipe")
    if FRC.savedVariables.debug then
      command:AddAlias("/frc")
    end
    command:SetCallback(FurnishingRecipeCollector.FRC_Toggle)
    command:SetDescription("Furniture Recipe Collector List")
  else
    SLASH_COMMANDS["/furrecipe"] = FurnishingRecipeCollector.FRC_Toggle
    if FRC.savedVariables.debug then
      SLASH_COMMANDS["/frc"] = FurnishingRecipeCollector.FRC_Toggle
    end
  end

  --Show the window after a delay
  if FRC.savedVariables.debug then
    zo_callLater(function()
      FurnishingRecipeCollector.FRC_Show()
    end, 1000)
  end
end

--[[
  ==============================================
  AddOn global and loading
  ==============================================
--]]
FRC = FRC
EVENT_MANAGER:RegisterForEvent(FRC.Name, EVENT_ADD_ON_LOADED, OnLoad)