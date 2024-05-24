FRC = FRC or {}
FRC.Name = "FurnishingRecipeCollector"
FRC.DisplayName = "FurnishingRecipeCollector"
FRC.Author = "tomstock"
FRC.Version = "1.1"

FRC.Debug = false --Todo: Change that to false before setting live, or else tooltips will contain an extra ID row at the end
FRC.logger = nil

--------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------
--ZOs local speed-up/reference variables
local EM = EVENT_MANAGER
local SNM = SCREEN_NARRATION_MANAGER
local tos = tostring
local sfor = string.format
local tins = table.insert
local LCK = LibCharacterKnowledge

--[[
  ==============================================
  Setup LibDebugLogger as an optional dependency
  ==============================================
--]]
if LibDebugLogger and FRC.Debug then
  FRC.logger = LibDebugLogger.Create(FRC.Name)
  FRC.logger:Info("Loaded logger")
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

local function getRecipeDetail(itemLink)
  local vItemLinkId, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink, vGrabBagItemLinkId,vGrabBagItemLink = nil, nil, nil, nil, nil, nil, nil, nil,nil

  vItemType, vSpecialType = GetItemLinkItemType(itemLink)
  vItemLinkId = GetItemLinkItemId(itemLink)

  if FRC.Data.Folios[vItemLinkId] ~= nil then
    -- This is a folio
    vFolioItemLinkId = vItemLinkId
    vFolioItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  elseif FRC.Data.FurnisherDocuments[vItemLinkId] ~= nil then
    -- This is a grab bag
    vGrabBagItemLinkId = vItemLinkId
    vGrabBagItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  elseif vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ALCHEMY_FORMULA_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_BLACKSMITHING_DIAGRAM_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_CLOTHIER_PATTERN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ENCHANTING_SCHEMATIC_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_JEWELRYCRAFTING_SKETCH_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_DESIGN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_WOODWORKING_BLUEPRINT_FURNISHING then
      --This is a furnishing recipe

      --Loop through each folio looking for recipe
      for i in pairs(FRC.Data.Folios) do
        for j in pairs(FRC.Data.Folios[i]) do
          --if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.Folios[i][j]).." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

          if FRC.Data.Folios[i][j] == vItemLinkId then
            if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vFolioItemLinkId = i
            vFolioItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            break
          end
        end
        if vFolioItemLinkId ~= nil then
          break
        end
      end
      if vFolioItemLinkId == nil then
        --Loop through each grabn bag looking for recipe, if not found earlier
        for i in pairs(FRC.Data.FurnisherDocuments) do
          for j in pairs(FRC.Data.FurnisherDocuments[i]) do
            --if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.FurnisherDocuments[i][j]).." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

            if FRC.Data.FurnisherDocuments[i][j] == vItemLinkId then
              if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
              vGrabBagItemLinkId = i
              vGrabBagItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
              break
            end
          end
          if vGrabBagItemLinkId ~= nil then
            break
          end
        end
      end
    elseif vItemType == ITEMTYPE_FURNISHING then
      --This is a furnishing item
      local resultLink
      local resultItemId

      --Loop through each folio looking for recipe
      for i in pairs(FRC.Data.Folios) do
        for j in pairs(FRC.Data.Folios[i]) do
          resultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
          resultItemId = GetItemLinkItemId(resultLink)
          -- if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.Folios[i][j]).." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..vItemLinkId.." "..itemLink) end

          if resultItemId == vItemLinkId then
            if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vFolioItemLinkId = i
            vFolioItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            vRecipeItemLinkId = FRC.Data.Folios[i][j]
            vRecipeItemLink = "|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            break
          end
        end
        if vFolioItemLinkId ~= nil then
          break
        end
      end
      if vFolioItemLinkId == nil then
        --Loop through each grabn bag looking for recipe, if not found earlier
        for i in pairs(FRC.Data.FurnisherDocuments) do
          for j in pairs(FRC.Data.FurnisherDocuments[i]) do
            resultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
            resultItemId = GetItemLinkItemId(resultLink)
            -- if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.FurnisherDocuments[i][j]).." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..vItemLinkId.." "..itemLink) end

            if resultItemId == vItemLinkId then
              if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
              vGrabBagItemLinkId = i
              vGrabBagItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
              vRecipeItemLinkId = FRC.Data.FurnisherDocuments[i][j]
              vRecipeItemLink = "|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
              break
            end
          end
          if vGrabBagItemLinkId ~= nil then
            break
          end
        end
      end
    end

  return vItemLinkId, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink, vGrabBagItemLinkId,vGrabBagItemLink
end

local function GetWritVendorContainerStats(vendorContainerLinkId)
  local vCharacterString = ""
  local vRecipeCount = nil
  local container = FRC.Data.Folios[vendorContainerLinkId] or FRC.Data.FurnisherDocuments[vendorContainerLinkId]

  vRecipeCount = table.getn(container)

  if LCK ~= nil then
    if container ~= nil then
      local tChars = {}
      local charactercolor = ""

      for j,recipeId in ipairs(container) do
        local knowl = LCK.GetItemKnowledgeList(recipeId, nil,nil)

        for i, knowledge in ipairs(knowl) do
          if knowledge["knowledge"] == LCK.KNOWLEDGE_KNOWN then
            if tChars[knowledge["id"]] == nil then
              tChars[knowledge["id"]] = 1
            else
              tChars[knowledge["id"]] = tChars[knowledge["id"]] + 1
            end
          elseif knowledge["knowledge"] == LCK.KNOWLEDGE_UNKNOWN then
            if tChars[knowledge["id"]] == nil then
              tChars[knowledge["id"]] = 0
            end
          end
        end
      end

      local chrList=LCK.GetCharacterList( nil )

      for i, chr in ipairs(chrList) do
        if tChars[chr["id"]] ~= nil then

          if tChars[chr["id"]] == 0 then
            charactercolor = 0x777766
          elseif tChars[chr["id"]] == table.getn(container) then
            charactercolor = 0x55ff1c
          else
            charactercolor = 0x3399FF
          end
          if vCharacterString ~= "" then
            vCharacterString = vCharacterString..", "
          end
          vCharacterString = vCharacterString..string.format("|c%06X%s|r", charactercolor, chr["name"].." ("..tChars[chr["id"]].."/"..table.getn(container)..")")
        end
      end
    end
  end
  return vCharacterString, vRecipeCount
end

local function adjustToolTip(tooltipControl, itemLink)
  local fontStyle = "MEDIUM_FONT"
  local fontSizeH1 = 14
  local fontSizeH2 = 12
  local fontWeight = "soft-shadow-thin"
  local vItemLinkId, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink, vGrabBagItemLinkId,vGrabBagItemLink = getRecipeDetail(itemLink)


  if vFolioItemLinkId ~= nil or vRecipeItemLinkId ~= nil or vGrabBagItemLinkId ~= nil then
    if FRC.logger ~= nil then FRC.logger:Verbose("LinkID:"..tos(vItemLinkId).." ItemType:"..tos(vItemType).." SpType:"..tos(vSpecialType).." Folio:"..tos(vFolioItemLinkId).." Recipe:"..tos(vRecipeItemLinkId).." GrabBag:"..tos(vGrabBagItemLinkId)) end

    if vRecipeItemLinkId ~= nil then
      --Recipe or Recipe Furnisher
      local vCharacterString, vRecipeCount = GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)

      tooltipControl:AddLine("Recipe available in Writ Vendor Folio: ",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      tooltipControl:AddLine((vFolioItemLink or vGrabBagItemLink),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      if LCK ~= nil then
        tooltipControl:AddLine("Folio Knowledge: "..vCharacterString,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        ZO_Tooltip_AddDivider(tooltipControl)
        tooltipControl:AddLine(vRecipeItemLink,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        local chars= LCK.GetItemKnowledgeList(vRecipeItemLinkId,nil,nil)
        local characterstring = ""
        local knownCount = 0

        for i, char in ipairs(chars) do
          if FRC.logger ~= nil then FRC.logger:Verbose(tos(char["name"]).." "..tos(char["knowledge"])) end
          if char.knowledge == LCK.KNOWLEDGE_KNOWN or char.knowledge == LCK.KNOWLEDGE_UNKNOWN then
            if char.knowledge == LCK.KNOWLEDGE_KNOWN then knownCount = knownCount + 1 end
            if characterstring ~= "" then
              characterstring = characterstring..", "
            end
            characterstring = characterstring..string.format("|c%06X%s|r", FRC.Colors[char.knowledge], char["name"])
          end
        end

        tooltipControl:AddLine("Known By "..knownCount.."/"..table.getn(chars)..": "..characterstring,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      else
        tooltipControl:AddLine("Recipe Count: "..vRecipeCount,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      end
      if TamrielTradeCentrePrice~= nil then
        local priceDetail = TamrielTradeCentrePrice:GetPriceInfo(vRecipeItemLink)
        if(priceDetail~=nil) then
          tooltipControl:AddLine("Average Price: "..zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(priceDetail["Avg"])),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
          tooltipControl:AddLine("Listings: "..priceDetail["EntryCount"],string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        end
      end
    elseif vGrabBagItemLinkId ~= nil then
      --Grab Bag
      local vCharacterString, vRecipeCount = GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)

      tooltipControl:AddLine("Recipe available in Writ Vendor Folio: ",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      tooltipControl:AddLine((vFolioItemLink or vGrabBagItemLink),string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      if LCK ~= nil then
        tooltipControl:AddLine("Folio Knowledge: "..vCharacterString,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      else
        tooltipControl:AddLine("Recipe Count: "..vRecipeCount,string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
      end
    elseif vFolioItemLinkId ~= nil then
      --Folio
      local vCharacterString, vRecipeCount = GetWritVendorContainerStats(vFolioItemLinkId or vGrabBagItemLinkId)

      ZO_Tooltip_AddDivider(tooltipControl)
      for i,recipeId in ipairs(FRC.Data.Folios[vItemLinkId]) do
        if FRC.logger ~= nil then FRC.logger:Verbose(tos(recipeId)) end
        tooltipControl:AddLine("|H1:item:"..recipeId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",string.format("$(%s)|$(KB_%s)|%s", fontStyle, fontSizeH1, fontWeight))
        if LCK ~= nil then
          local charKnowledge = LCK.GetItemKnowledgeList( recipeId )
          if charKnowledge ~= nil then
            local characterstring = ""
              for i, knowledge in ipairs(charKnowledge) do
                if FRC.logger ~= nil then FRC.logger:Verbose(tos(knowledge["name"]).." "..tos(knowledge["knowledge"])) end

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
      if LCK ~= nil then
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

  HookTooltips()

end

--[[
  ==============================================
  AddOn global and loading
  ==============================================
--]]
FRC = FRC
EVENT_MANAGER:RegisterForEvent(FRC.Name, EVENT_ADD_ON_LOADED, OnLoad)