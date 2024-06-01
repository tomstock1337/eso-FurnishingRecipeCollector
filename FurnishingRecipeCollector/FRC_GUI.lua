FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector

local tos = tostring

--[[
  Global Window Events
]]
function FRC.GuiOnControlMouseUp(control, button)
  if nil == control then
    return
  end

  if button ~= 2 then
    return
  end
  local itemLink = control.itemLink

  if nil == itemLink then
    return
  end
  local recipeArray = FurC.Find(itemLink)
  if {} == recipeArray then
    return
  end

  -- if not menuEventQueued then
  --   menuEventQueued = true
  --   zo_callLater(function()
  --     ItemTooltip:SetHidden(true)
  --     ClearMenu()
  --     addMenuItems(itemLink, recipeArray, true)
  --     ShowMenu()
  --     menuEventQueued = false
  --   end, 50)
  -- end
end
function FRC.GuiOnResizeStop()
  FRC.GuiSaveFrameInfo()
  FRC.UpdateLineVisibility()
  FRC.UpdateInventoryScroll()
end
function FRC.GuiOnSliderUpdate(slider, value)
  if not value or slider and slider.locked then
    return
  end
  local relativeValue = math.floor(FRC_GUI_ListHolder.dataOffset - value)
  FRC.GuiOnScroll(slider, relativeValue)
end
function FRC.GuiOnScroll(control, delta)
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
function FRC.GuiLineOnMouseEnter(lineControl)
  currentLink, currentId = nil, nil

  if not lineControl or not lineControl.itemLink or lineControl.itemLink == "" then
    return
  end
  currentLink = lineControl.itemLink
  currentId = lineControl.itemId

  if nil == currentLink then
    return
  end

  -- InitializeTooltip(ItemTooltip, lineControl, LEFT, 0, 0, 0)
  -- ItemTooltip:SetLink(currentLink)
end
function FRC.GuiLineOnMouseExit(lineControl)
  -- ItemTooltip:SetHidden(true)
end
function FRC.GuiSaveFrameInfo(calledFrom)
  --functions hooked from GUI can't be local
  local gui_s = FRC.savedVariables["gui"]

  gui_s.lastX = FRC_GUI:GetLeft()
  gui_s.lastY = FRC_GUI:GetTop()
  gui_s.width = FRC_GUI:GetWidth()
  gui_s.height = FRC_GUI:GetHeight()

  FRC.UpdateInventoryScroll()
end

--[[
    Global functions used by other addon callbacks or XML
]]
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
    curLine:SetHidden(hidden)
    if nil == curData or curLine:IsHidden() then
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
      curLine.lblRecipeName:SetText("")
      curLine.lblLocation:SetText("")
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
      curLine.lblRecipeName:SetText(curLine.rRecipeItemLink)
      curLine.lblLocation:SetText(curLine.rFolioItemLink or curLine.rGrabBagItemLink or curLine.rLocation)
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

  if nil ~= task then
    task:Call(redrawList)
  else
    redrawList()
  end
end
--[[
    Local functions
]]
function FRC.RestorePosition()
  local control = FRC_GUI
  local gui_s = FRC.savedVariables["gui"]
  local left = gui_s.lastX
  local top = gui_s.lastY

  control:SetHeight(gui_s.height)
  control:SetWidth(gui_s.width)

  control:ClearAnchors()
  control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)

  zo_callLater(function()
    FRC.UpdateInventoryScroll()
  end, 100)
end

function FRC.updateScrollDataLinesData()
  local dataLines = {}

  for i in pairs(FRC.Data.FurnisherDocuments) do
    for j in pairs(FRC.Data.FurnisherDocuments[i]) do
      local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(FRC.Data.FurnisherDocuments[i][j])
      local tempDataLine = {}
      tempDataLine.rItemLinkId = vItemLinkId
      tempDataLine.rItemName = vItemName
      tempDataLine.rItemType = vItemType
      tempDataLine.rSpecialType = vSpecialType
      tempDataLine.rFolioItemLinkId = vFolioItemLinkId
      tempDataLine.rFolioItemLink = vFolioItemLink
      tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
      tempDataLine.rRecipeItemLink = vRecipeItemLink
      tempDataLine.rRecipeItemName = vRecipeItemName
      tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
      tempDataLine.rGrabBagItemLink = vGrabBagItemLink
      tempDataLine.rLocation = vLocation
      table.insert(dataLines, tempDataLine)
    end
  end
  for i in pairs(FRC.Data.Folios) do
    for j in pairs(FRC.Data.Folios[i]) do
      local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(FRC.Data.Folios[i][j])
      local tempDataLine = {}
      tempDataLine.rItemLinkId = vItemLinkId
      tempDataLine.rItemName = vItemName
      tempDataLine.rItemType = vItemType
      tempDataLine.rSpecialType = vSpecialType
      tempDataLine.rFolioItemLinkId = vFolioItemLinkId
      tempDataLine.rFolioItemLink = vFolioItemLink
      tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
      tempDataLine.rRecipeItemLink = vRecipeItemLink
      tempDataLine.rRecipeItemName = vRecipeItemName
      tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
      tempDataLine.rGrabBagItemLink = vGrabBagItemLink
      tempDataLine.rLocation = vLocation
      table.insert(dataLines, tempDataLine)
    end
  end
  for i in pairs(FRC.Data.Misc)do
    local vItemLinkId, vItemName, vItemType, vSpecialType, vFolioItemLinkId,vFolioItemLink, vRecipeItemLinkId,vRecipeItemLink,vRecipeItemName, vGrabBagItemLinkId,vGrabBagItemLink,vLocation = FRC.GetRecipeDetail(i)
    local tempDataLine = {}
    tempDataLine.rItemLinkId = vItemLinkId
    tempDataLine.rItemName = vItemName
    tempDataLine.rItemType = vItemType
    tempDataLine.rSpecialType = vSpecialType
    tempDataLine.rFolioItemLinkId = vFolioItemLinkId
    tempDataLine.rFolioItemLink = vFolioItemLink
    tempDataLine.rRecipeItemLinkId = vRecipeItemLinkId
    tempDataLine.rRecipeItemLink = vRecipeItemLink
    tempDataLine.rRecipeItemName = vRecipeItemName
    tempDataLine.rGrabBagItemLinkId = vGrabBagItemLinkId
    tempDataLine.rGrabBagItemLink = vGrabBagItemLink
    tempDataLine.rLocation = vLocation
    table.insert(dataLines, tempDataLine)
  end
  FRC_GUI_ListHolder.dataLines = dataLines
end
local function SetupPostXMLGui()
  local function createInventoryScroll()
    FurC.Logger:Debug("CreateInventoryScroll")
    local function createLine(i, predecessor)
      predecessor = predecessor or FRC_GUI_ListHolder

      --@type Control
      local line = WINDOW_MANAGER:CreateControlFromVirtual("FRC_GUI_ItemListRow_" .. i, FRC_GUI_ListHolder, "FRC_GUI_ItemListRow")

      line.lblRecipeName = line:GetNamedChild("_RecipeName")
      line.lblLocation = line:GetNamedChild("_Location")

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

    local predecessor
    for i = 1, FRC_GUI_ListHolder.maxLines do
      FRC_GUI_ListHolder.lines[i] = createLine(i, predecessor)
      predecessor = FRC_GUI_ListHolder.lines[i]
    end

    -- setup slider
    FRC_GUI_ListHolder_Slider:SetMinMax(0, #FRC_GUI_ListHolder.dataLines - FRC_GUI_ListHolder.maxLines)

    return FRC_GUI_ListHolder.lines
  end

  createInventoryScroll()
end

function FRC.UpdateGui()
  FRC.updateScrollDataLinesData()
  zo_callLater(FRC.UpdateLineVisibility, 200)
end

function FRC.InitGui()
  local control = FRC_GUI

  FRC.RestorePosition()

  SetupPostXMLGui()

  local slider = FRC_GUI_ListHolder_Slider
  slider:SetMinMax(1, #FRC_GUI_ListHolder.dataLines)

  FRC.UpdateGui()

  SCENE_MANAGER:RegisterTopLevel(control, false)
  FRC.logger:Debug("GUI Initialized")
end
