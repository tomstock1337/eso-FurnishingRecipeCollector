FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector
FRC.Data = FRC.Data or {}
--https://en.uesp.net/wiki/Online:Furnisher_Documents
FRC.Data.Misc = {
  [203319]={location="Faustina Writ Vendor"}, --Blueprint: Pergola, Reclaimed Wood
  [203320]={location="Faustina Writ Vendor"}, --Design: Apocrypha Tree, Spore
  [203323]={location="Faustina Writ Vendor"}, --Diagram: Apocrypha Bookcase Platform
  [203321]={location="Faustina Writ Vendor"}, --Formula: Apocrypha Light Diffuser, Stalk
  [203322]={location="Faustina Writ Vendor"}, --Pattern: Apocrypha Book Press
  [203325]={location="Faustina Writ Vendor"}, --Praxis: Apocrypha Wall, Eye
  [203324]={location="Faustina Writ Vendor"}, --Sketch: Apocrypha Mirror, Intricate
  [211033]={location="Rolis Hlaalu Writ Vendor"}, --Formula: Colovian Alembic Set, Colorful
  [211034]={location="Rolis Hlaalu Writ Vendor"}, --Diagram: Colovian Chandelier, Grapes
  [211035]={location="Rolis Hlaalu Writ Vendor"}, --Pattern: Colovian Tapestry, Red Diamond
  [211036]={location="Rolis Hlaalu Writ Vendor"}, --Praxis: Colovian Glassblower's Furnace
  [211037]={location="Rolis Hlaalu Writ Vendor"}, --Sketch: Colovian Mirror, Standing
  [211038]={location="Rolis Hlaalu Writ Vendor"}, --Design: Dawnwood Platter, Feast
  [211039]={location="Rolis Hlaalu Writ Vendor"}, --Blueprint: Colovian Keg, Gigantic Wine
  --The following are always at Rolis
  [126582]={location="Rolis Hlaalu Writ Vendor"}, --Praxis: Target Centurion, Dwarf-Brass
  [126583]={location="Rolis Hlaalu Writ Vendor"}, --Praxis: Target Centurion, Robust Refabricated
  [119592]={location="Rolis Hlaalu Writ Vendor"}, --Praxis: Target Skeleton, Humanoid
  [121315]={location="Rolis Hlaalu Writ Vendor"}, --Praxis: Target Skeleton, Robust Humanoid
  [119391]={location="Brewer"}, --Design: Common Candle, Set
  [139487]={location="Nalirswewen, Artaeum"}, --Praxis: Book Row, Levitating
  [139488]={location="Nalirswewen, Artaeum"}, --Praxis: Book Stack, Levitating
  [139489]={location="Nalirswewen, Artaeum"}, --Blueprint: Psijic Chair, Arched
  [139490]={location="Nalirswewen, Artaeum"}, --Blueprint: Psijic Table, Small
  [139491]={location="Nalirswewen, Artaeum"}, --Praxis: Psijic Lighting Globe, Small
  [139492]={location="Nalirswewen, Artaeum"}, --Praxis: Psijic Table, Scalloped
  [139493]={location="Nalirswewen, Artaeum"}, --Pattern: Psijic Banner
  [139494]={location="Nalirswewen, Artaeum"}, --Praxis: Psijic Table, Six-fold Symmetry
  [139495]={location="Nalirswewen, Artaeum"}, --Praxis: Psijic Lighting Globe, Large
  [139496]={location="Nalirswewen, Artaeum"}, --Pattern: Psijic Banner, Large
  [139497]={location="Nalirswewen, Artaeum"}, --Praxis: Psijic Table, Grand
  [141901]={location="Nalirswewen, Artaeum"}, --Pattern: Psijic Banner, Long
  --The following are special cases that are not in the writ folios and grab bags
  [119098]={location="Pickpocketing Nobles in Orsinium"}, --Blueprint: Orcish Throne, Peaked
  [119077]={location="Pickpocketing Nobles in Orsinium"}, --Praxis: Orcish Throne, Engraved
  [119076]={location="Pickpocketing Nobles in Orsinium"}, --Praxis: Orcish Throne, Stone
  [211415]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Bench, Long Ornate Backed
  [211416]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Bench, Ornate Backed
  [211417]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Bench, Ornate
  [211428]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Bracket, Ornate Stone
  [211423]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Cage, Ornate
  [211424]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Diagram: Ayleid Chandelier, Metal Tiered
  [211425]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Diagram: Ayleid Chandelier, Sturdy Caged
  [211418]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Counter, Stone
  [211426]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Diagram: Ayleid Crystal Star
  [211429]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Formula: Ayleid Crystal, Cracked
  [211419]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Desk, Ornate Stone
  [211421]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Jewelry Box, Ornate Stone
  [211422]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Lamp, Ornate Stone
  [211414]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Pedestal, Empty
  [211427]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Diagram: Ayleid Sconce, Caged
  [211420]={location="West Weald, Gold Coast, Blackwood Antiquity bonus, intermediate or above"}, --Praxis: Ayleid Wardrobe, Ornate Stone
}