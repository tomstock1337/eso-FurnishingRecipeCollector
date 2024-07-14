FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector

--------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------
local tos = tostring
local LCK = LibCharacterKnowledge
local LR = LibRecipe

--------------------------------------------------------------------
-- Recipe Functions
--------------------------------------------------------------------
function FRC.GetRecipeDetail(itemLinkOrItemID)
  local itemLink
  local vItemLinkId, vItemName, vItemFunctionalQuality, vItemType, vSpecialType, vFolioItemLinkId, vFolioItemLink, vFolioItemName, vRecipeItemLinkId, vRecipeItemLink, vRecipeItemName, vGrabBagItemLinkId, vGrabBagItemLink, vGrabBagItemName, vLocation, vResultLinkId, vResultLink, vResultName, vRecipePrice, vRecipeListing = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil

  if type(itemLinkOrItemID) == "string" then
    itemLink = itemLinkOrItemID
  else
    itemLink = "|H1:item:"..itemLinkOrItemID..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  end

  vItemType, vSpecialType = GetItemLinkItemType(itemLink)
  vItemLinkId = GetItemLinkItemId(itemLink)
  vItemName = GetItemLinkName(itemLink)
  vItemFunctionalQuality = GetItemLinkFunctionalQuality(itemLink)

  if FRC.Data.Folios[vItemLinkId] ~= nil then
    -- This is a folio
    vFolioItemLinkId = vItemLinkId
    vFolioItemLink = "|H1:item:"..vFolioItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    vFolioItemName = vItemName
  elseif FRC.Data.FurnisherDocuments[vItemLinkId] ~= nil then
    -- This is a grab bag
    vGrabBagItemLinkId = vItemLinkId
    vGrabBagItemLink = "|H1:item:"..vGrabBagItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    vGrabBagItemName = vItemName
  elseif FRC.Data.Misc[vItemLinkId] ~= nil then
    -- This is a recipe with special location
    vRecipeItemLinkId = vItemLinkId
    vRecipeItemLink = "|H1:item:"..vRecipeItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    vRecipeItemName = GetItemLinkName(vRecipeItemLink)
    vLocation = FRC.Data.Misc[vRecipeItemLinkId].location
    vResultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..vRecipeItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
    vResultLinkId = GetItemLinkItemId(vResultLink)
    vResultName = GetItemLinkName(vResultLink)
  elseif vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ALCHEMY_FORMULA_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_BLACKSMITHING_DIAGRAM_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_CLOTHIER_PATTERN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ENCHANTING_SCHEMATIC_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_JEWELRYCRAFTING_SKETCH_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_DESIGN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_WOODWORKING_BLUEPRINT_FURNISHING then
      --This is a furnishing recipe
      vRecipeItemLinkId = vItemLinkId
      vRecipeItemLink = "|H1:item:"..vRecipeItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
      vRecipeItemName = GetItemLinkName(vRecipeItemLink)
      vResultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..vRecipeItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
      vResultLinkId = GetItemLinkItemId(vResultLink)
      vResultName = GetItemLinkName(vResultLink)

      --Loop through each folio looking for recipe
      for i in pairs(FRC.Data.Folios) do
        for j in pairs(FRC.Data.Folios[i]) do
          --if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.Folios[i][j]).." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..vResultLinkId..resultLink ) end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

          if FRC.Data.Folios[i][j] == vItemLinkId then
            --if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vFolioItemLinkId = i
            vFolioItemLink = "|H1:item:"..vFolioItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            vFolioItemName = GetItemLinkName(vFolioItemLink)
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
            --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..vResultLinkId..resultLink ) end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

            if FRC.Data.FurnisherDocuments[i][j] == vItemLinkId then
              --if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
              vGrabBagItemLinkId = i
              vGrabBagItemLink = "|H1:item:"..vGrabBagItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
              vGrabBagItemName = GetItemLinkName(vGrabBagItemLink)
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
    -- local craftingStationType, recipeListIndex,recipeIndex = GetRecipeInfoFromItemId(vItemLinkId)
    -- local recipeListName, numRecipes, upIcon, downIcon, overIcon, _, recipeListCreateSound = GetRecipeListInfo(recipeListIndex)
    -- local known_, name_, numIngredients_, provisionerLevelReq_, qualityReq_, specialIngredientType_, requiredCraftingStationType_, resultItemId_ GetRecipeInfo(recipeListIndex,recipeIndex)
    -- local link = GetRecipeIngredientItemLink(recipeListIndex, recipeIndex, i, LINK_STYLE_BRACKETS)
    vResultLinkId = vItemLinkId
    vResultLink = "|H1:item:"..vResultLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    vResultName = GetItemLinkName(vResultLink)

    --Loop through each folio looking for recipe
    for i in pairs(FRC.Data.Folios) do
      for j in pairs(FRC.Data.Folios[i]) do
        local vSearchResultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
        local vSearchResultLinkId = GetItemLinkItemId(vSearchResultLink)

        if vResultLinkId == vSearchResultLinkId then
          --if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          vFolioItemLinkId = i
          vFolioItemLink = "|H1:item:"..vFolioItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
          vFolioItemName = GetItemLinkName(vFolioItemLink)
          vRecipeItemLinkId = FRC.Data.Folios[i][j]
          vRecipeItemLink = "|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
          vRecipeItemName = GetItemLinkName(vRecipeItemLink)
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
          local vSearchResultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
          local vSearchResultLinkId = GetItemLinkItemId(vSearchResultLink)

          if vResultLinkId == vSearchResultLinkId then
            --if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vGrabBagItemLinkId = i
            vGrabBagItemLink = "|H1:item:"..vGrabBagItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            vGrabBagItemName = GetItemLinkName(vGrabBagItemLink)
            vRecipeItemLinkId = FRC.Data.FurnisherDocuments[i][j]
            vRecipeItemLink = "|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            vRecipeItemName = GetItemLinkName(vRecipeItemLink)
            break
          end
        end
        if vGrabBagItemLinkId ~= nil then
          break
        end
      end
    end
    if vFolioItemLinkId == nil and vGrabBagItemLinkId == nil then
      --Loop through each misc looking for recipe, if not found earlier
      for i in pairs(FRC.Data.Misc) do
        local vSearchResultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
        local vSearchResultLinkId = GetItemLinkItemId(vSearchResultLink)

        if vResultLinkId == vSearchResultLinkId then
          --if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Misc[i]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          vRecipeItemLinkId = i
          vRecipeItemLink = "|H1:item:"..vRecipeItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
          vRecipeItemName = GetItemLinkName(vRecipeItemLink)
          vLocation = FRC.Data.Misc[vRecipeItemLinkId].location
          break
        end
      end
    end
    if vFolioItemLinkId == nil and vGrabBagItemLinkId == nil and vLocation == nil then
      --Use LibRecipe to get the result item

      if LR ~= nil then
        vRecipeItemLink = LR:GetRecipeItemLink(vResultLink)
        vRecipeItemLinkId = GetItemLinkItemId(vRecipeItemLink)
        vRecipeItemName = GetItemLinkName(vRecipeItemLink)
      end
    end
  end

  if TamrielTradeCentrePrice~= nil then
    --TODO: This can be configurable
    local priceTable = TamrielTradeCentrePrice:GetPriceInfo(vRecipeItemLink)
    if priceTable ~= nil then
      if priceTable["Avg"] ~= nil then
        vRecipePrice = priceTable["Avg"]
      end
      if priceTable["EntryCount"] ~= nil then
        vRecipeListing = priceTable["EntryCount"]
      end
    end
  end

  return vItemLinkId, vItemName, vItemFunctionalQuality, vItemType, vSpecialType, vFolioItemLinkId, vFolioItemLink, vFolioItemName, vRecipeItemLinkId, vRecipeItemLink, vRecipeItemName, vGrabBagItemLinkId, vGrabBagItemLink, vGrabBagItemName, vLocation, vResultLinkId, vResultLink, vResultName, vRecipePrice, vRecipeListing
end

function FRC.GetWritVendorContainerStats(vendorContainerLinkId)
  local vVendorCharacterString = ""
  local vVendorRecipeCount = nil
  local container = FRC.Data.Folios[vendorContainerLinkId] or FRC.Data.FurnisherDocuments[vendorContainerLinkId]

  if container == nil then
    return
  end
  vVendorRecipeCount = table.getn(container)

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
            charactercolor = FRC.savedVariables.colorAllUnknown
          elseif tChars[chr["id"]] == table.getn(container) then
            charactercolor = FRC.savedVariables.colorAllKnown
          else
            charactercolor = FRC.savedVariables.colorAllPartial
          end
          if vVendorCharacterString ~= "" then
            vVendorCharacterString = vVendorCharacterString..", "
          end
          vVendorCharacterString = vVendorCharacterString..string.format("|c%06X%s|r", charactercolor, chr["name"].." ("..tChars[chr["id"]].."/"..table.getn(container)..")")
        end
      end
    end
  end
  return vVendorCharacterString, vVendorRecipeCount
end

function FRC.GetRecipeKnowledge(vRecipeItemLinkOrItemId)
  local vCharacterStringLong = ""
  local vCharacterStringShort = ""
  local vCharTrackedCount = 0
  local vCharKnownCount = 0
  local vRecipeItemLinkId = 0

  if type(vRecipeItemLinkOrItemId) == "string" then
    vRecipeItemLinkId = GetItemLinkItemId(vRecipeItemLinkOrItemId)
  else
    vRecipeItemLinkId = vRecipeItemLinkOrItemId
  end

  if LCK ~= nil then
    local tChars= LCK.GetItemKnowledgeList(vRecipeItemLinkId,nil,nil)
    local charColor = nil

    for i, chr in ipairs(tChars) do
      if chr["knowledge"] == LCK.KNOWLEDGE_KNOWN then
        vCharTrackedCount = vCharTrackedCount + 1
        vCharKnownCount = vCharKnownCount + 1
        charColor = FRC.savedVariables.colorCharKnown
      elseif chr["knowledge"] == LCK.KNOWLEDGE_UNKNOWN then
        vCharTrackedCount = vCharTrackedCount + 1
        charColor = FRC.savedVariables.colorCharUnknown
      end

      if chr["knowledge"] == LCK.KNOWLEDGE_KNOWN or chr["knowledge"] == LCK.KNOWLEDGE_UNKNOWN then
        if vCharacterStringLong ~= "" then
          vCharacterStringLong = vCharacterStringLong..", "
        end
        vCharacterStringLong = vCharacterStringLong..string.format("|c%06X%s|r", charColor, chr["name"])
      end
    end
    if vCharKnownCount == 0 then
      vCharacterStringShort = string.format("|c%06X%s|r", FRC.savedVariables.colorAllUnknown, tos(vCharKnownCount).."/"..tos(vCharTrackedCount))
    elseif vCharKnownCount == vCharTrackedCount then
      vCharacterStringShort = string.format("|c%06X%s|r", FRC.savedVariables.colorAllKnown, tos(vCharKnownCount).."/"..tos(vCharTrackedCount))
    else
      vCharacterStringShort = string.format("|c%06X%s|r", FRC.savedVariables.colorAllPartial, tos(vCharKnownCount).."/"..tos(vCharTrackedCount))
    end
  end
  return vCharacterStringLong, vCharacterStringShort, vCharTrackedCount, vCharKnownCount
end