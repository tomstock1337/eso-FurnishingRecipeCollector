FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector
local LCK = LibCharacterKnowledge

local tos = tostring
FRC.isGuiLoading = nil
FRC.sortOptions =
  {
    ["Location"] = {
      "locationSort",
      {
        ["locationSort"]=
          {
            tiebreaker = "rResultName",
            tieBreakerSortOrder=ZO_SORT_ORDER_UP
          },
        ["rResultName"]=
          {
          }
      }
    },
    ["Item"] = {
      "rResultName",
      {
        ["rResultName"]=
          {
          }
      }
    },
    ["Knowledge"] = {
      "kKnown",
      {
        ["kKnown"]=
          {
            tiebreaker = "locationSort",
            tieBreakerSortOrder=ZO_SORT_ORDER_UP
          },
        ["locationSort"]=
          {
          }
      }
    }
  }

--[[
  Global Window Events
]]
function FRC.GuiOnResizeStop()
  FRC.GuiSaveFrameInfo()
  if FRC.isGuiLoading == true then
    return
  end
  FRC.UpdateLineVisibility()
  FRC.UpdateInventoryScroll()
end
function FRC.GuiOnSliderUpdate(slider, value)
  if nil == slider or FRC.isGuiLoading == true then
    return
  end
  if not value or (slider and slider.locked) then
    return
  end
  local relativeValue = math.floor(FRC_GUI_ListHolder.dataOffset - value)
  FRC.GuiOnScroll(slider, relativeValue)
end
function FRC.GuiOnScroll(control, delta)
  if nil == control or FRC.isGuiLoading == true then
    return
  end
  if not delta then
    return
  end
  if delta == 0 then
    return
  end

  local slider = FRC_GUI_ListHolder_Slider
  --  slider.locked = true
  -- negative delta means scrolling down

  local value = (FRC_GUI_ListHolder.dataOffset - delta)
  local total = #FRC_GUI_ListHolder.dataLines -FRC_GUI_ListHolder.maxLines

  if value < 0 then
    value = 0
  end
  if value > total then
    value = total
  end
  FRC_GUI_ListHolder.dataOffset = value

  FurnishingRecipeCollector.UpdateInventoryScroll()

  slider:SetValue(FRC_GUI_ListHolder.dataOffset)

  FurnishingRecipeCollector.GuiLineOnMouseEnter(moc())
end
function FRC.GuiLineOnMouseEnter(lineControlChild)

  local lineControl = lineControlChild:GetParent()

  if nil == lineControl or FRC.isGuiLoading == true then
    return
  end

  if (lineControl.rFolioItemLink or "") == "" and (lineControl.rGrabBagItemLink or "") == "" and (lineControl.rRecipeItemLink or "") == "" then
    return
  end


  if moc():GetName() == lineControl.lblLocation:GetName() then
    if lineControl.rFolioItemLink ~= nil then
      InitializeTooltip(ItemTooltip, lineControl, LEFT, 0, 0, 0)
      ItemTooltip:SetLink(lineControl.rFolioItemLink)
    elseif lineControl.rGrabBagItemLink ~= nil then
      InitializeTooltip(ItemTooltip, lineControl, LEFT, 0, 0, 0)
      ItemTooltip:SetLink(lineControl.rGrabBagItemLink)
    end
  elseif lineControl.rRecipeItemLink ~= nil then
    InitializeTooltip(ItemTooltip, lineControl, LEFT, 0, 0, 0)
    ItemTooltip:SetLink(lineControl.rRecipeItemLink)
  end
end
function FRC.GuiLineOnMouseExit(lineControlChild)
  if nil == lineControlChild or FRC.isGuiLoading == true then
    return
  end
  ClearTooltip(ItemTooltip)
end
function FRC.GuiSaveFrameInfo(calledFrom)
  --functions hooked from GUI can't be local
  local gui_s = FRC.savedVariables["gui"]

  gui_s.lastX = FRC_GUI:GetLeft()
  gui_s.lastY = FRC_GUI:GetTop()
  gui_s.width = FRC_GUI:GetWidth()
  gui_s.height = FRC_GUI:GetHeight()

  if FRC.isGuiLoading == false then
    FRC.UpdateInventoryScroll()
  end
end
function FRC.GUIButtonRefreshOnMouseUp(calledFrom,mouseButton)
  FRC.UpdateGui()
end

function FRC.GuiOnSort(sortKey)
  if FRC.savedVariables.gui.sort == sortKey then
    if FRC.savedVariables.gui.sortDirection == ZO_SORT_ORDER_UP then
      FRC.savedVariables.gui.sortDirection = ZO_SORT_ORDER_DOWN
    else
      FRC.savedVariables.gui.sortDirection = ZO_SORT_ORDER_UP
    end
  else
    FRC.savedVariables.gui.sortDirection = ZO_SORT_ORDER_UP
  end
  FRC.savedVariables.gui.sort = sortKey
  FRC.UpdateGui()
end

--[[
    Global functions used by other addon callbacks or XML
]]
function FRC.SortDataLines(data,orderIndex,direction)
  table.sort(data, function(item1, item2) return ZO_TableOrderingFunction(item1, item2, FRC.sortOptions[orderIndex][1],FRC.sortOptions[orderIndex][2],direction) end)
end
function FRC.FRC_Toggle()
  --functions hooked from other addons can't be local
  SCENE_MANAGER:ToggleTopLevel(FRC_GUI)
end
function FRC.FRC_Show()
  --functions hooked from other addons can't be local
  SCENE_MANAGER:ShowTopLevel(FRC_GUI)
end
function FRC.CalculateMaxLines()
  if not FRC_GUI_Header then
    return
  end
  FRC_GUI_ListHolder:SetHeight(FRC_GUI:GetHeight() - FRC_GUI_Header:GetHeight())
  FRC_GUI_ListHolder.maxLines = math.floor((FRC_GUI_ListHolder:GetHeight()) / FRC_GUI_ListHolder.lines[1]:GetHeight())
  return FRC_GUI_ListHolder.maxLines
end
function FRC.UpdateInventoryScroll()
  FRC_GUI_ListHolder.dataOffset = FRC_GUI_ListHolder.dataOffset or 0
  FRC_GUI_ListHolder.dataOffset = math.max(FRC_GUI_ListHolder.dataOffset, 0)

  FRC.CalculateMaxLines()

  local total = #FRC_GUI_ListHolder.dataLines - FRC_GUI_ListHolder.maxLines
  if total > 0 then
    FRC_GUI_ListHolder_Slider:SetMinMax(0, total)
  end

  FRC.UpdateLineVisibility()
end
function FRC.UpdateLineVisibility()
  local function fillLine(curLine, curData, lineIndex)
    if nil == curLine then
      return
    end

    local dataLines = FRC_GUI_ListHolder.dataLines
    local maxLines = FRC_GUI_ListHolder.maxLines

    local hidden = lineIndex > #dataLines or lineIndex > maxLines
    curLine:SetHidden(hidden) --this may not be working
    if curData == nil or hidden then
      curLine.rItemLinkId = 0
      curLine.rItemName = ""
      curLine.rItemType = 0
      curLine.rSpecialType = 0
      curLine.rFolioItemLinkId = 0
      curLine.rFolioItemLink = ""
      curLine.rRecipeItemLinkId = 0
      curLine.rRecipeItemLink = ""
      curLine.rRecipeItemName = ""
      curLine.rGrabBagItemLinkId = 0
      curLine.rGrabBagItemLink = ""
      curLine.rLocation = ""
      curLine.rResultLinkId = 0
      curLine.rResultLink = ""
      curLine.rResultName = ""
      curLine.kKnown = ""
      curLine.lblRecipeName:SetText("")
      curLine.lblLocation:SetText("")
      curLine.lblKnowledge:SetText("")
    else
      curLine.rItemLinkId = curData.rItemLinkId
      curLine.rItemName = curData.rItemName
      curLine.rItemType = curData.rItemType
      curLine.rSpecialType = curData.rSpecialType
      curLine.rFolioItemLinkId = curData.rFolioItemLinkId
      curLine.rFolioItemLink = curData.rFolioItemLink
      curLine.rRecipeItemLinkId = curData.rRecipeItemLinkId
      curLine.rRecipeItemLink = curData.rRecipeItemLink
      curLine.rRecipeItemName = curData.rRecipeItemName
      curLine.rGrabBagItemLinkId = curData.rGrabBagItemLinkId
      curLine.rGrabBagItemLink = curData.rGrabBagItemLink
      curLine.rLocation = curData.rLocation
      curLine.rResultLinkId = curData.rResultLinkId
      curLine.rResultLink = curData.rResultLink
      curLine.rResultName = curData.rResultName
      curLine.kKnown = curData.kKnown
      curLine.lblRecipeName:SetText(curLine.rRecipeItemLink)
      curLine.lblLocation:SetText(curLine.rFolioItemLink or curLine.rGrabBagItemLink or curLine.rLocation)
      curLine.lblKnowledge:SetText(curLine.kKnown)
    end
  end

  FRC.CalculateMaxLines()

  local function redrawList()
    local maxLines = FRC_GUI_ListHolder.maxLines
    local dataLines = FRC_GUI_ListHolder.dataLines

    local offset = FRC_GUI_ListHolder_Slider:GetValue()
    if offset > #dataLines then
      offset = 0
    end
    FRC_GUI_ListHolder_Slider:SetValue(offset)

    local curLine, curData

    for i = 1, FRC_GUI_ListHolder:GetNumChildren() do
      curLine = FRC_GUI_ListHolder.lines[i]
      curData = FRC_GUI_ListHolder.dataLines[offset + i]
      fillLine(curLine, curData, i)
    end
    FRC_GUI_ListHolder_Slider:SetMinMax(0, #dataLines)
  end

  redrawList()
end
function FRC.RestorePosition()
  local control = FRC_GUI
  local gui_s = FRC.savedVariables["gui"]
  local left = gui_s.lastX
  local top = gui_s.lastY

  control:SetHeight(gui_s.height)
  control:SetWidth(gui_s.width)

  control:ClearAnchors()
  control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)

  if isLoadingInd == false then
    zo_callLater(function()
      FRC.UpdateInventoryScroll()
    end, 100)
  end
end

function FRC.UpdateScrollDataLinesData()
  local dataLines = {}

  for i in pairs(FRC.Data.FurnisherDocuments) do
    for j in pairs(FRC.Data.FurnisherDocuments[i]) do
      local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId, vFolioItemLink, vFolioItemName, vRecipeItemLinkId, vRecipeItemLink, vRecipeItemName, vGrabBagItemLinkId, vGrabBagItemLink, vGrabBagItemName, vLocation, vResultLinkId, vResultLink, vResultName = FRC.GetRecipeDetail(FRC.Data.FurnisherDocuments[i][j])
      local vCharacterStringLong, vCharacterStringShort, vCharTrackedCount, vCharKnownCount = FRC.GetRecipeKnowledge(vRecipeItemLinkId)
      local tempDataLine = {}
      tempDataLine.rItemLinkId = vItemLinkId
      tempDataLine.rItemName = vItemName
      tempDataLine.rItemType = vItemType
      tempDataLine.rSpecialType = vSpecialType
      tempDataLine.rFolioItemLinkId = vFolioItemLinkId
      tempDataLine.rFolioItemLink = vFolioItemLink
      tempDataLine.rFolioItemName = vFolioItemName or ""
      tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
      tempDataLine.rRecipeItemLink = vRecipeItemLink
      tempDataLine.rRecipeItemName = vRecipeItemName
      tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
      tempDataLine.rGrabBagItemLink = vGrabBagItemLink
      tempDataLine.rGrabBagItemName = vGrabBagItemName or ""
      tempDataLine.rLocation = vLocation
      tempDataLine.rResultLinkId = vResultLinkId
      tempDataLine.rResultLink = vResultLink
      tempDataLine.rResultName = vResultName
      tempDataLine.kKnown = vCharacterStringShort
      table.insert(dataLines, tempDataLine)
    end
  end
  for i in pairs(FRC.Data.Folios) do
    for j in pairs(FRC.Data.Folios[i]) do
      local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId, vFolioItemLink, vFolioItemName, vRecipeItemLinkId, vRecipeItemLink, vRecipeItemName, vGrabBagItemLinkId, vGrabBagItemLink, vGrabBagItemName, vLocation, vResultLinkId, vResultLink, vResultName = FRC.GetRecipeDetail(FRC.Data.Folios[i][j])
      local vCharacterStringLong, vCharacterStringShort, vCharTrackedCount, vCharKnownCount = FRC.GetRecipeKnowledge(vRecipeItemLinkId)
      local tempDataLine = {}
      tempDataLine.rItemLinkId = vItemLinkId
      tempDataLine.rItemName = vItemName
      tempDataLine.rItemType = vItemType
      tempDataLine.rSpecialType = vSpecialType
      tempDataLine.rFolioItemLinkId = vFolioItemLinkId
      tempDataLine.rFolioItemLink = vFolioItemLink
      tempDataLine.rFolioItemName = vFolioItemName or ""
      tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
      tempDataLine.rRecipeItemLink = vRecipeItemLink
      tempDataLine.rRecipeItemName = vRecipeItemName
      tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
      tempDataLine.rGrabBagItemLink = vGrabBagItemLink
      tempDataLine.rGrabBagItemName = vGrabBagItemName or ""
      tempDataLine.rLocation = vLocation
      tempDataLine.rResultLinkId = vResultLinkId
      tempDataLine.rResultLink = vResultLink
      tempDataLine.rResultName = vResultName
      tempDataLine.kKnown = vCharacterStringShort
      table.insert(dataLines, tempDataLine)
    end
  end
  for i in pairs(FRC.Data.Misc)do
    local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId, vFolioItemLink, vFolioItemName, vRecipeItemLinkId, vRecipeItemLink, vRecipeItemName, vGrabBagItemLinkId, vGrabBagItemLink, vGrabBagItemName, vLocation, vResultLinkId, vResultLink, vResultName = FRC.GetRecipeDetail(i)
    local vCharacterStringLong, vCharacterStringShort, vCharTrackedCount, vCharKnownCount = FRC.GetRecipeKnowledge(vRecipeItemLinkId)
    local tempDataLine = {}
    tempDataLine.rItemLinkId = vItemLinkId
    tempDataLine.rItemName = vItemName
    tempDataLine.rItemType = vItemType
    tempDataLine.rSpecialType = vSpecialType
    tempDataLine.rFolioItemLinkId = vFolioItemLinkId
    tempDataLine.rFolioItemLink = vFolioItemLink
    tempDataLine.rFolioItemName = vFolioItemName
    tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
    tempDataLine.rRecipeItemLink = vRecipeItemLink
    tempDataLine.rRecipeItemName = vRecipeItemName
    tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
    tempDataLine.rGrabBagItemLink = vGrabBagItemLink
    tempDataLine.rGrabBagItemName = vGrabBagItemName
    tempDataLine.rLocation = vLocation
    tempDataLine.rResultLinkId = vResultLinkId
    tempDataLine.rResultLink = vResultLink
    tempDataLine.rResultName = vResultName
    tempDataLine.kKnown = vCharacterStringShort
    table.insert(dataLines, tempDataLine)
  end


  for i,line in pairs(dataLines) do
    if line.rFolioItemLinkId ~= nil then
      line.locationSort = "1_"..line.rFolioItemName
    elseif line.rGrabBagItemLinkId ~= nil then
      line.locationSort = "2_"..line.rGrabBagItemName
    else line.locationSort = "3_"..line.rLocation
    end
  end

  FRC.SortDataLines(dataLines,FRC.savedVariables.gui.sort, FRC.savedVariables.gui.sortDirection)

  FRC_GUI_ListHolder.dataLines = dataLines
end
function FRC.LoadingStart()
  FRC.isGuiLoading = true
  FRC_GUI_ListHolder:SetHidden(true)
  FRC_GUI_Wait:SetHidden(false)
end

function FRC.LoadingStop()
  FRC.isGuiLoading = false
  FRC_GUI_ListHolder:SetHidden(false)
  FRC_GUI_Wait:SetHidden(true)
end
local function CreatePostXMLGui()
  local function CreateInventoryScroll()
    FRC.logger:Debug("CreateInventoryScroll")
    local function createLine(i, predecessor)
      predecessor = predecessor or FRC_GUI_ListHolder

      --@type Control
      local line = WINDOW_MANAGER:CreateControlFromVirtual("FRC_GUI_ItemListRow_" .. i, FRC_GUI_ListHolder, "FRC_GUI_ItemListRow")

      line.lblRecipeName = line:GetNamedChild("_RecipeName")
      line.lblLocation = line:GetNamedChild("_Location")
      line.lblKnowledge = line:GetNamedChild("_Knowledge")

      line:SetHidden(false)
      line:SetMouseEnabled(true)

      if i == 1 then
        line:SetAnchor(TOPLEFT, FRC_GUI_ListHolder, TOPLEFT, 0, 4)
        line:SetAnchor(TOPRIGHT, FRC_GUI_ListHolder, TOPRIGHT, -30, 0)
      else
        line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
        line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
      end
      return line
    end

    FRC_GUI_ListHolder.dataOffset = 0
    FRC_GUI_ListHolder.maxLines = 60
    FRC_GUI_ListHolder.dataLines = {}
    FRC_GUI_ListHolder.lines = {}
    FRC_GUI_ListHolder.Sort1 = FRC_GUI_SortBar_Sort1:GetNamedChild("_Name")
    FRC_GUI_ListHolder.Sort1.icon = FRC_GUI_SortBar_Sort1:GetNamedChild("_Button")
    FRC_GUI_ListHolder.Sort2 = FRC_GUI_SortBar_Sort2:GetNamedChild("_Name")
    FRC_GUI_ListHolder.Sort2.icon = FRC_GUI_SortBar_Sort2:GetNamedChild("_Button")
    FRC_GUI_ListHolder.Sort3 = FRC_GUI_SortBar_Sort2:GetNamedChild("_Name")
    FRC_GUI_ListHolder.Sort3.icon = FRC_GUI_SortBar_Sort2:GetNamedChild("_Button")

    local predecessor
    for i = 1, FRC_GUI_ListHolder.maxLines do
      FRC_GUI_ListHolder.lines[i] = createLine(i, predecessor)
      predecessor = FRC_GUI_ListHolder.lines[i]
    end

    -- setup slider
    FRC_GUI_ListHolder_Slider:SetMinMax(0, #FRC_GUI_ListHolder.dataLines - FRC_GUI_ListHolder.maxLines)

    return FRC_GUI_ListHolder.lines
  end
  local function CreateDropDown(dropDownType)
    FRC.logger:Debug("CreateDropDown")
    local filterControl = nil
    local data = {}
    local comboBox = nil

    function OnItemSelect(control, entryText, entry)
      -- local dropdownName = tostring(control.m_name):gsub("FRC_Dropdown", "")
      -- FRC.SetDropdownChoice(dropdownName, choiceText)
    end

    if dropDownType == "Folio" then
      filterControl = _G["FRC_GUI_FilterFolio"]

      table.insert(data,{callback=OnItemSelect,enabled=true,name="Location: No Filter",itemLinkId="",itemName="",categoryId="0NoSelection"})

      --Grabbed structure of combobox item from zo_combobox_base.lua
      for i in pairs(FRC.Data.Folios) do
        local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(i)
        table.insert(data,{callback=OnItemSelect,enabled=true,name=vFolioItemLink,itemLinkId=vItemLinkId,itemName=vItemName,categoryId="1Folio"})
      end
      for i in pairs(FRC.Data.FurnisherDocuments) do
        local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(i)
        table.insert(data,{callback=OnItemSelect,enabled=true,name=vGrabBagItemLink,itemLinkId=vItemLinkId,itemName=vItemName,categoryId="2FurnisherDocuments"})
      end
      table.insert(data,{callback=OnItemSelect,name="Misc",categoryId="3Misc"})
    else return
    end

    filterControl.comboBox = filterControl.comboBox or ZO_ComboBox_ObjectFromContainer(filterControl)
    comboBox = filterControl.comboBox

    local scrollHelper = AddCustomScrollableComboBoxDropdownMenu(comboBox, filterControl, {})

    comboBox:ClearItems()

    table.sort(data, function(item1, item2) return ZO_TableOrderingFunction(item1, item2, "categoryId",{["categoryId"]={tiebreaker = "itemName",tieBreakerSortOrder=ZO_SORT_ORDER_UP},["itemName"]={caseInsensitive=true}},ZO_SORT_ORDER_UP) end)

		comboBox:AddItems(data)
    comboBox:SetSelected(1)
  end

  CreateInventoryScroll()
  CreateDropDown("Folio")

  local slider = FRC_GUI_ListHolder_Slider
  slider:SetMinMax(1, #FRC_GUI_ListHolder.dataLines)
end

function FRC.UpdateGui()
  FRC.LoadingStart()
  FRC.UpdateScrollDataLinesData()
  zo_callLater(function()
    FRC.UpdateInventoryScroll()
    FRC.LoadingStop()
  end, 100)
end

function FRC.InitGui()
  local control = FRC_GUI

  FRC.RestorePosition()

  CreatePostXMLGui()

  local slider = FurCGui_ListHolder_Slider
  slider:SetMinMax(1, #FurCGui_ListHolder.dataLines)

  if LCK ~= nil then
    LCK.RegisterForCallback("FurnishingRecipeCollector", LCK.EVENT_INITIALIZED, function( )
      FRC.UpdateGui()
    end)
  else FRC.UpdateGui()
  end

  SCENE_MANAGER:RegisterTopLevel(control, false)
end
