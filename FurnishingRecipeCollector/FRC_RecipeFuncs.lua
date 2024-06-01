FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector

--------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------
local tos = tostring
local LCK = LibCharacterKnowledge

--------------------------------------------------------------------
-- Recipe Functions
--------------------------------------------------------------------
function FRC.GetRecipeDetail(itemLinkOrItemID)
  local itemLink
  local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = nil,nil,nil, nil, nil, nil, nil, nil, nil, nil,nil,nil

  if type(itemLinkOrItemID) == "string" then
    itemLink = itemLinkOrItemID
  else
    itemLink = "|H1:item:"..itemLinkOrItemID..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  end

  vItemType, vSpecialType = GetItemLinkItemType(itemLink)
  vItemLinkId = GetItemLinkItemId(itemLink)
  vItemName = GetItemLinkName(itemLink)

  if FRC.Data.Folios[vItemLinkId] ~= nil then
    -- This is a folio
    vFolioItemLinkId = vItemLinkId
    vFolioItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  elseif FRC.Data.FurnisherDocuments[vItemLinkId] ~= nil then
    -- This is a grab bag
    vGrabBagItemLinkId = vItemLinkId
    vGrabBagItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
  elseif FRC.Data.Misc[vItemLinkId] ~= nil then
    -- This is a recipe with special location
    vRecipeItemLinkId = vItemLinkId
    vRecipeItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    vRecipeItemName = GetItemLinkName(vRecipeItemLink)
    vLocation = FRC.Data.Misc[vItemLinkId].location
  elseif vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ALCHEMY_FORMULA_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_BLACKSMITHING_DIAGRAM_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_CLOTHIER_PATTERN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_ENCHANTING_SCHEMATIC_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_JEWELRYCRAFTING_SKETCH_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_DESIGN_FURNISHING
    or vSpecialType == SPECIALIZED_ITEMTYPE_RECIPE_WOODWORKING_BLUEPRINT_FURNISHING then
      --This is a furnishing recipe
      vRecipeItemLinkId = vItemLinkId
      vRecipeItemLink = "|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
      vRecipeItemName = GetItemLinkName(vRecipeItemLink)

      --Loop through each folio looking for recipe
      for i in pairs(FRC.Data.Folios) do
        for j in pairs(FRC.Data.Folios[i]) do
          --if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.Folios[i][j]).." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
          --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

          if FRC.Data.Folios[i][j] == vItemLinkId then
            -- if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vFolioItemLinkId = i
            vFolioItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
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
            --if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.FurnisherDocuments[i][j]).." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
            --if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..itemLinkId.." "..itemLink) end

            if FRC.Data.FurnisherDocuments[i][j] == vItemLinkId then
              -- if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
              vGrabBagItemLinkId = i
              vGrabBagItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
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
            -- if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Folios[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vFolioItemLinkId = i
            vFolioItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
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
            resultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
            resultItemId = GetItemLinkItemId(resultLink)
            -- if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Folio: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(FRC.Data.FurnisherDocuments[i][j]).." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
            -- if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..vItemLinkId.." "..itemLink) end

            if resultItemId == vItemLinkId then
              -- if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.FurnisherDocuments[i][j]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
              vGrabBagItemLinkId = i
              vGrabBagItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
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
        for i in pairs(FRC.Data.Misc)do
          resultLink = GetItemLinkRecipeResultItemLink("|H1:item:"..tos(i)..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
          resultItemId = GetItemLinkItemId(resultLink)
          -- if FRC.logger ~= nil then FRC.logger:Verbose("==============================") end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Recipe ID: "..tos(i).." ".."|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Result Link ID: "..resultItemId..resultLink ) end
          -- if FRC.logger ~= nil then FRC.logger:Verbose("Search ID: "..vItemLinkId.." "..itemLink) end

          if resultItemId == vItemLinkId then
            -- if FRC.logger ~= nil then FRC.logger:Verbose("|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..FRC.Data.Misc[i]..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h".." ".."|H1:item:"..vItemLinkId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") end
            vRecipeItemLinkId = i
            vRecipeItemLink = "|H1:item:"..i..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            vRecipeItemName = GetItemLinkName(vRecipeItemLink)
            vLocation = FRC.Data.Misc[i].location
            break
          end
        end
      end
    end

  return vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName,vGrabBagItemLinkId,vGrabBagItemLink,vLocation
end

function FRC.GetWritVendorContainerStats(vendorContainerLinkId)
  local vCharacterString = ""
  local vRecipeCount = nil
  local container = FRC.Data.Folios[vendorContainerLinkId] or FRC.Data.FurnisherDocuments[vendorContainerLinkId]

  if container == nil then
    return
  end
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