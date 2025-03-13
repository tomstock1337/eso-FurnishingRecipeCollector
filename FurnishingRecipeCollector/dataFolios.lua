FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector
FRC.Data = FRC.Data or {}
--https://en.uesp.net/wiki/Online:Furnisher_Documents
FRC.Data.Folios =
{
  [211090]= --Necrom Furnishing Folio
  {
    198062, --Blueprint: Necrom Cart, Funerary
    198065, --Design: Indoril Chandelier, Vine-Covered
    198061, --Diagram: Dwarven Door, Bronze
    198064, --Formula: Telvanni Lantern, Luminous Mushroom
    198060, --Pattern: Dark Elf Tent, Multiroom
    198063, --Praxis: Necrom Crematory, Furnace
    198059, --Sketch: Daedric Mirror, Nightmarish
  },
  [190121] = --Blackwood Furnishing Folio
  {
    181557, -- Blueprint: Leyawiin Divider, Carved Starfish
    181560, -- Design: Leyawiin Bowl, Squid Special
    181556, -- Diagram: Deadlands Torture Rack
    181561, -- Formula: Blackwood Cottage Painting, Unframed
    181558, -- Pattern: Leyawiin Tapestry, Hunting Party
    181559, -- Praxis: Leyawiin Hearth, Carved Wood
    181562, -- Sketch: Leyawiin Lightpost, Ornate
  },
  [171568] = --Crafter's Furnishing Folio
  {
    121200, --Crafter’s  Blueprint: Cabinet, Poisonmaker’s
    121166, --Crafter’s  Blueprint: Podium, Skinning
    121168, --Crafter’s  Blueprint: Tools, Case
    121199, --Crafter’s  Design: Mortar and Pestle
    121214, --Crafter’s  Design: Orcish Skull Goblet, Full
    121163, --Crafter’s  Diagram: Apparatus, Boiler
    121165, --Crafter’s  Diagram: Apparatus, Gem Calipers
    121197, --Crafter’s  Formula: Bottle, Poison Elixir
    121164, --Crafter’s  Formula: Case of Vials
    121209, --Crafter’s  Pattern: Orcish Tapestry, Spear
    121207, --Crafter’s  Praxis: Orcish Table with Fur
  },
  [171571] = --Dark Elf Furnishing Folio
  {
    134987, --Dark Elf  Blueprint: Hlaalu Gaming Table, “Foxes &amp; Felines”
    134986, --Dark Elf  Design: Miniature Garden, Bottled
    134983, --Dark Elf  Diagram: Hlaalu Gong
    134982, --Dark Elf  Formula: Alchemical Apparatus, Master
    134984, --Dark Elf  Pattern: Clothier’s Form, Brass
    134985, --Dark Elf  Praxis: Hlaalu Trinket Box, Curious Turtle
  },
  [194429] = --Deadlands Furnishing Folio
  {
    184154, --Deadlands  Blueprint: Alinor Easel, Carved
    184156, --Deadlands  Design: Blackwood Provisioning Station
    184150, --Deadlands  Diagram: Deadlands Throne
    184152, --Deadlands  Formula: Fargrave Water Globules, Static
    184151, --Deadlands  Pattern: Deadlands Tapestry, Mehrunes Dagon
    184149, --Deadlands  Praxis: Deadlands Puzzle Cube
    184153, --Deadlands  Sketch: Fargrave Window, Grand Medallion
  },
  [171778] = --Dragonhold Funrishing Folio
  {
    159500, --Dragonhold  Blueprint: Elsweyr Well, Covered
    159503, --Dragonhold  Design: Elsweyr Bread Basket, Feast-Day
    159498, --Dragonhold  Diagram: Elsweyr Gong, Ornate
    159502, --Dragonhold  Formula: Elsweyr Mortar and Pestle, Engraved
    159499, --Dragonhold  Pattern: Elsweyr Bed, Senche-Raht
    159501, --Dragonhold  Praxis: Khajiit Sigil, Moon Cycle
    159504, --Dragonhold  Sketch: Elsweyr Game, Swan Stones
  },
  [171573] = --Ebonheart Furnishing Folio
  {
    147652, --Ebonheart  Blueprint: Frog-Caller, Untuned
    147653, --Ebonheart  Design: Pottery Wheel, Ever-Turning
    147657, --Ebonheart  Diagram: Hlaalu Stove, Chiminea
    147654, --Ebonheart  Formula: Alchemical Apparatus, Condenser
    147656, --Ebonheart  Pattern: Dark Elf Tent, Canopy
    147655, --Ebonheart  Praxis: Hlaalu Salt Lamp, Enchanted
    147651, --Ebonheart  Sketch: Silver Kettle, Masterworked
  },
  [171574] = --Elsweyr Furnishing Folio
  {
    153731, --Elsweyr  Blueprint: Elsweyr Cart, Masterwork
    153734, --Elsweyr  Design: Provisioning Station, Elsweyr Grill
    153729, --Elsweyr  Diagram: Elsweyr Gate, Masterwork
    153733, --Elsweyr  Formula: Elsweyr Incense, Fragrant
    153730, --Elsweyr  Pattern: Elsweyr Chaise Lounge, Upholstered
    153732, --Elsweyr  Praxis: Elsweyr Statue, Shrine Lion
    153735, --Elsweyr  Sketch: Elsweyr Cage, Filigree
  },
  [204499] = --Galen Furnishing Folio
  {
    194398, --Galen Blueprint: Druidic Bridge, Living
    194394, --Galen Design: Druidic Oven, Stone
    194397, --Galen Diagram: Statue, Bronze Tentacle
    194393, --Galen Forumula: Druidic Throne, Y'ffre's Bloom
    194395, --Galen Pattern: Mage Tapestry, Aurbic Phoenix
    194396, --Galen Praxis: Stone, Lava-Etched
    194392, --Galen Sketch: Resonance Crystal, Cerulean
  },
  [198597] = --High Isle Furnishing Folio
  {
    190080, --High Isle  Blueprint: High Isle Caravel, Miniature
    190079, --High Isle  Design: Shark Jaw, Massive
    190075, --High Isle  Diagram: High Isle Beacon, Unlit
    190074, --High Isle  Formula: Potted Trees, Stonelore Dogwood
    190076, --High Isle  Pattern: High Isle Tapestry, Seaside Tourney
    190077, --High Isle  Praxis: High Isle Heartlh, Tilework
    190078, --High Isle  Sketch: High Isle Hourglass, Gold
  },
  [184192] = --Markarth Furnishing Folio
  {
    171803, --Markarth  Blueprint: Solitude Well, Noble
    171806, --Markarth  Design: Provisioning Station, Solitude Grill
    171801, --Markarth  Diagram: Dwarven Minecart, Ornate
    171805, --Markarth  Formula: Vampiric Cauldron, Distilled Coagulant
    171802, --Markarth  Pattern: Solitude Yarn Rack, Colorful
    171804, --Markarth  Praxis: Solitude Hearth, Rounded Tall
    171807, --Markarth  Sketch: Dwarven Crystal Sconce, Mirror
  },
  [171569] = --Morrowind Furnishing Folio
  {
    132195, --Morrowind  Blueprint: Telvanni Candelabra, Masterwork
    132194, --Morrowind  Design: Mammoth Cheese, Mastercrafted
    132191, --Morrowind  Diagram: Dwarven Gyroscope, Masterwork
    132190, --Morrowind  Formula: Mages Apparatus, Master
    132192, --Morrowind  Pattern: Dres Sewing Kit, Master’s
    132193, --Morrowind  Praxis: Hlaalu Bath Tub, Masterwork
  },
  [171572] = --Summerset Furnishing Folio
  {
    141904, --Summerset  Blueprint: Alinor Bookshelf, Grand Full
    141907, --Summerset  Design: Alinor Grape Stomping Tub
    141902, --Summerset  Diagram: Relic Vault, Impenetrable
    141906, --Summerset  Formula: Artist’s Palette, Pigment
    141903, --Summerset  Pattern: Alinor Bed, Levitating
    141905, --Summerset  Praxis: Alinor Gaming Table, Punctilious Conflict
    139486, --Summerset  Sketch: Alinor Ancestor Clock, Celestial
    141896, --Summerset  Sketch: Figurine, The Dragon’s Glare
  },
  [171808] = --Western Skyrim Furnishing Folio
  {
    167380, --Western Skyrim  Blueprint: Solitude Game, Blood-on-the-Snow
    167383, --Western Skyrim  Design: Solitude Smoking Rack, Fish
    167378, --Western Skyrim  Diagram: Vampiric Chandelier, Azure Wrought-Iron
    167382, --Western Skyrim  Formula: Winter Cardinal Painting, In Progress
    167379, --Western Skyrim  Pattern: Solitude Loom, Warp-Weighted
    167381, --Western Skyrim  Praxis: Ancient Nord Monolith, Head
    167384, --Western Skyrim  Sketch: Blackreach Geode, Iridescent
  },
  [214255] = --Tomehold Furnishing Folio
  {
    203319, --Blueprint: Pergola, Reclaimed Wood
    203320, --Design: Apocrypha Tree, Spore
    203323, --Diagram: Apocrypha Bookcase Platform
    203321, --Formula: Apocrypha Light Diffuser, Stalk
    203322, --Pattern: Apocrypha Book Press
    203325, --Praxis: Apocrypha Wall, Eye
    203324, --Sketch: Apocrypha Mirror, Intricate
  }
}