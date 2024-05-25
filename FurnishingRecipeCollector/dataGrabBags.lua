FurnishingRecipeCollector = FurnishingRecipeCollector or {}
local FRC = FurnishingRecipeCollector
FRC.Data = FRC.Data or {}
--https://en.uesp.net/wiki/Online:Furnisher_Documents
FRC.Data.FurnisherDocuments =
{
  [184191] =  --Blackwood Journeyman Furnisher's Document
  {
    166921, --Blueprint: Solitude Backpack, Basket
    166919, --Blueprint: Solitude Basket, Centerpiece
    166920, --Blueprint: Solitude Basket, Ornate
    166918, --Blueprint: Solitude Basket, Wicker Wide
    166849, --Blueprint: Solitude Cabinet, Ornate Wall
    166865, --Blueprint: Solitude Cabinet, Rustic Filled
    166832, --Blueprint: Solitude Dresser, Rustic
    166862, --Blueprint: Solitude Jewelry Box, Wolf's-Head
    166848, --Blueprint: Solitude Nightstand, Noble Cabinet
    166810, --Blueprint: Solitude Pew, Sturdy Long
    166916, --Blueprint: Solitude Picnic Basket, Wicker
    166824, --Blueprint: Solitude Table, Round Small
    166830, --Blueprint: Solitude Wardrobe, Rustic
    166931, --Design: Solitude Bowl, Berries
    166930, --Design: Solitude Bowl, Mushrooms
    166944, --Design: Solitude Bread, Floral Pattern
    166947, --Design: Solitude Bread, Rustic Loaf
    166943, --Design: Solitude Breakfast, Sausages and Ham
    166939, --Design: Solitude Camping Pot, Fish Stew
    166936, --Design: Solitude Dinner Bowl, Hearty Stew
    166938, --Design: Solitude Dinner Bowl, Vegetable Soup
    166954, --Design: Solitude Drying Rack, Stockfish
    166895, --Diagram: Solitude Hand-Drill, Simple
    166925, --Diagram: Solitude Frying Pan, Long-Handled
    166907, --Diagram: Solitude Pot, Stout Metal
    166860, --Diagram: Solitude Trunk, Knotwork
    166891, --Pattern: Solitude Bed, Rustic Bearskin Single
    166794, --Pattern: Solitude Carpet, Small Plush
    166898, --Pattern: Solitude Patching Kit, Well-Worn
    166787, --Pattern: Solitude Rug, Cowhide
    166793, --Pattern: Solitude Rug, Knotwork
    166788, --Pattern: Solitude Rug, Snow Bear
    166951, --Sketch: Solitude Goblet, Noble
    166911, --Sketch: Solitude Serving Bowl, Verdigris
  },
  [184190] =  --Blackwood Master Furnisher's Document
  {
    175954, --Blueprint: Leyawiin Armchair, Cushioned
    175922, --Blueprint: Leyawiin Armoire, Formal
    175956, --Blueprint: Leyawiin Bench, Cushioned
    175958, --Blueprint: Leyawiin Bench, Cushioned Wide
    175929, --Blueprint: Leyawiin Bookcase, Grand Filled
    175928, --Blueprint: Leyawiin Bookcase, Narrow Filled
    175926, --Blueprint: Leyawiin Bookcase, Tall Filled
    176024, --Blueprint: Leyawiin Counter, Wide Merchant
    175916, --Blueprint: Leyawiin Cupboard, Formal
    175921, --Blueprint: Leyawiin Cupboard, Formal Display
    175952, --Blueprint: Leyawiin Desk, Formal
    175982, --Blueprint: Leyawiin Divider, Octopus
    176025, --Blueprint: Leyawiin Merchant Stall, Portable
    175949, --Blueprint: Leyawiin Table, Formal Grand
    175964, --Blueprint: Leyawiin Trunk, Floral Gilded
    175962, --Blueprint: Leyawiin Trunk, Ornate
    176022, --Blueprint: Leyawiin Wagon, Covered
    175923, --Blueprint: Leyawiin Wardrobe, Formal
    176015, --Design: Leyawiin Pie, Octopus
    176009, --Design: Leyawiin Serving Pot, Lobster Stew
    175974, --Diagram: Leyawiin Brazier, Copper
    175972, --Diagram: Leyawiin Brazier, Tall Copper Serpent
    175991, --Diagram: Leyawiin Censer, Iron Stand
    175992, --Diagram: Leyawiin Censer, Serpents
    175979, --Diagram: Leyawiin Chandelier, Brass
    175978, --Diagram: Leyawiin Chandelier, Grand Brass
    175976, --Diagram: Leyawiin Lamp, Oil
    175975, --Diagram: Leyawiin Lamp, Oil Double
    175966, --Diagram: Leyawiin Lamppost, Floral Gilded
    175967, --Diagram: Leyawiin Sconce, Gilded Lantern
    175986, --Diagram: Leyawiin Wall Mirror, Silver
    175930, --Pattern: Leyawiin Bed, Formal Double
    175931, --Pattern: Leyawiin Bed, Formal Single
    175938, --Pattern: Leyawiin Carpet, Grand Carmine Octad
    175933, --Pattern: Leyawiin Tapestry, Floral
    175995, --Praxis: Leyawiin Amphora, Elegant
    175994, --Praxis: Leyawiin Pitcher, Elegant
    175983, --Praxis: Leyawiin Well, Covered
    176001, --Sketch: Leyawiin Hand Mirror, Silver
    175960, --Sketch: Leyawiin Jewelry Box, Gilded
    175961, --Sketch: Leyawiin Jewelry Box, Iron Octopus
  },
  [153623] =  --Clockwork Mixed Furnisher's Document
  {
    134516, --Design: Clockwork Bowl, Large Nutriment Paste
    134522, --Design: Clockwork Goblet, Recycled Water
    134526, --Design: Clockwork Meal, Dish
    134527, --Design: Clockwork Meal, Plate
    134546, --Design: Clockwork Paste Dispenser, Empty
    134509, --Diagram: Clockwork Cabinet, Sequence Plaque
    134502, --Diagram: Clockwork Chair, Practical
    134503, --Diagram: Clockwork Chair, Reinforced
    134518, --Diagram: Clockwork Coffer, Robust
    134505, --Diagram: Clockwork Drafting Table, Flat
    134504, --Diagram: Clockwork Drafting Table, Raised
    134500, --Diagram: Clockwork Furnace, Socketed
    134521, --Diagram: Clockwork Goblet, Empty
    134508, --Diagram: Clockwork Lectern, Empty
    134525, --Diagram: Clockwork Mug, Reinforced
    134513, --Diagram: Clockwork Nightstand, Octagonal
    134494, --Diagram: Clockwork Pump, Vertical
    134528, --Diagram: Clockwork Scales, Precision Calibrated
    134529, --Diagram: Clockwork Sequence Plaques, Folded
    134530, --Diagram: Clockwork Sequence Plaques, Unfolded
    134506, --Diagram: Clockwork Sequence Spool, Single
    134507, --Diagram: Clockwork Sequence Spool, Triple
    134501, --Diagram: Clockwork Somnolostation
    134534, --Diagram: Clockwork Surveyor's Tripod, Calibrated
    134511, --Diagram: Clockwork Table, Beveled
    134514, --Diagram: Clockwork Table, Grand
    134497, --Diagram: Clockwork Vent, Octagonal Fan
    134543, --Diagram: Clockwork Wall Machinery, Arched
    134515, --Diagram: Clockwork Wardrobe, Precision Engineered
    134493, --Formula: Clockwork Lamppost, Gas
    134482, --Formula: Fabricant Tree, Cobalt Spruce
    134479, --Formula: Fabricant Tree, Electrum
    134481, --Formula: Fabricant Tree, Miniature Cherry Blossom
    134480, --Formula: Fabricant Tree, Vibrant Cherry Blossom
    134477, --Formula: Fabricant Trees, Clustered Maple
    134544, --Praxis: Clockwork Charging Station, Animo Core
    134545, --Praxis: Clockwork Charging Station, Factotum
    134498, --Praxis: Clockwork Control Panel, Single
    134538, --Praxis: Clockwork Illuminator, Capsule Tower
    134540, --Praxis: Clockwork Illuminator, Compact
    134539, --Praxis: Clockwork Illuminator, Compact Stand
    134535, --Praxis: Clockwork Illuminator, Personal Desk
    134537, --Praxis: Clockwork Illuminator, Powered Capsule
    134536, --Praxis: Clockwork Illuminator, Solitary Capsule
    134524, --Praxis: Clockwork Mortar and Pestle, Sintered
    134496, --Praxis: Clockwork Switch, Sturdy
  },
  [190870] =  --Deadlands Mixed Furnisher's Document
  {
    182963, --Blueprint: Deadlands Armoire, Etched
    182964, --Blueprint: Deadlands Bookcase, Etched
    182940, --Blueprint: Deadlands Bookcase, Large Ashen
    183003, --Blueprint: Deadlands Bookcase, Large Cluttered
    182969, --Blueprint: Deadlands Table, Etched
    182968, --Blueprint: Deadlands Table, Long Etched
    182938, --Blueprint: Fargrave Counter, Merchant
    182939, --Blueprint: Fargrave Stall, Large Merchant
    182996, --Design: Fargrave Box of Fruit
    182948, --Design: Fargrave Bread and Sweetrolls
    182947, --Design: Fargrave Bread, Baguettes
    182946, --Design: Fargrave Bread, Round Loaves
    182995, --Design: Fargrave Bread, Various Loaves
    182999, --Design: Fargrave Corn, Bunch
    182997, --Design: Fargrave Fish Pile, Marinated Trout
    182949, --Design: Fargrave Meats
    182945, --Design: Fargrave Sausages
    182998, --Design: Fargrave Tomato Bunch
    182966, --Diagram: Deadlands Bench, Etched Wide
    182950, --Diagram: Deadlands Brazier, Large Etched
    182952, --Diagram: Deadlands Candelabra, Tall
    182951, --Diagram: Deadlands Candelabra, Tall Caged
    182954, --Diagram: Deadlands Candleholder, Etched
    182962, --Diagram: Deadlands Chair, Etched
    182953, --Diagram: Deadlands Crystal Brazier
    182955, --Diagram: Deadlands Sconce, Large
    182967, --Diagram: Deadlands Tenderizer
    182965, --Diagram: Deadlands Torture Table, Etched
    182957, --Formula: Deadlands Gems, Levitating
    182942, --Formula: Fargrave Gems, Levitating
    182972, --Formula: Fargrave Terrarium, Flower
    182975, --Formula: Fargrave Terrarium, Large Gas Blossom
    182974, --Formula: Fargrave Terrarium, Scuttlebloom
    182973, --Formula: Fargrave Terrarium, Small Gas Blossom
    182994, --Formula: Fargrave Terrarium, Watcher
    182976, --Pattern: Deadlands Carpet, Large
    182960, --Pattern: Deadlands Curtains, Closed
    182958, --Pattern: Deadlands Curtains, Open
    182977, --Pattern: Deadlands Rug
    182978, --Pattern: Deadlands Rug, Small
    182959, --Pattern: Deadlands Tapestry
    182961, --Pattern: Deadlands Tapestry, Long
    182941, --Pattern: Fargrave Book Stack, Levitating
    182970, --Praxis: Deadlands Lightning Rod, Crescent
    182971, --Praxis: Deadlands Lightning Rod, Spike
    183004, --Praxis: Fargrave Bench, Long Stone
    182937, --Praxis: Fargrave Bench, Stone
  },
  [159653] =  --Elsweyr Journeyman Furnisher's Document
  {
    152035, --Blueprint: Elsweyr Armchair, Low-Backed Wooden
    152055, --Blueprint: Elsweyr Cabinet, Elegant Wooden
    151979, --Blueprint: Elsweyr Meal, Hearty Noodles
    152059, --Blueprint: Elsweyr Nightstand, Wooden
    151978, --Design: Elsweyr Bowl, Deep Ceramic
    152086, --Design: Elsweyr Sconce, Candle Carved
    152106, --Diagram: Hakoshae Hook, Block
    152013, --Pattern: Elsweyr Bed, Rumpled Quilted Single
    152023, --Pattern: Elsweyr Curtains, Tied-Back Blue
    152105, --Pattern: Elsweyr Tapestry, Ruby-Maroon
    152104, --Pattern: Elsweyr Tapestry, Verdant Blossom
    152076, --Praxis: Elsweyr Lightpost, Ancient Stone
    152113, --Praxis: Elsweyr Platform, Stepped
    152003, --Praxis: Elsweyr Sand Meditation Ring, Large
    152115, --Praxis: Elsweyr Stairs, Masonry
    152006, --Sketch: Elsweyr Incense Burner, Tall Brass
    152082, --Sketch: Elsweyr Lantern, Metal Ring
    151990, --Sketch: Elsweyr Sugar Bowl, Gilded
  },
  [159654] =  --Elsweyr Master Furnisher's Document
  {
    152033, --Blueprint: Elsweyr Armchair, Elegant Wooden
    152036, --Blueprint: Elsweyr Armchair, Low-Backed Elegant
    152043, --Blueprint: Elsweyr Bookcase, Elegant Wooden Full
    152045, --Blueprint: Elsweyr Bookcase, Short Elegant Full
    152041, --Blueprint: Elsweyr Bookcase, Wooden Full
    152056, --Blueprint: Elsweyr Cabinet, Wide Elegant Wooden
    152052, --Blueprint: Elsweyr Chest, Red Gilded
    152120, --Blueprint: Elsweyr Couch, Elegant Wooden
    152046, --Blueprint: Elsweyr Cupboard, Elegant Wooden
    152065, --Blueprint: Elsweyr Desk, Elegant Wooden
    151982, --Blueprint: Elsweyr Meal, Whole Roasted Chicken
    152068, --Blueprint: Elsweyr Nightstand, Elegant Wooden
    152067, --Blueprint: Elsweyr Nightstand, Octagonal Wooden
    151981, --Blueprint: Elsweyr Plate, Umber Ceramic
    152057, --Blueprint: Elsweyr Room-Divider, Elegant
    152020, --Blueprint: Elsweyr Stall Counter, Triple
    152069, --Blueprint: Elsweyr Table, Elegant Wooden
    152066, --Blueprint: Elsweyr Table, Long Wooden
    152070, --Blueprint: Elsweyr Table, Wide Elegant Wooden
    152034, --Blueprint: Elsweyr Throne, Elegant Wooden
    152049, --Blueprint: Elsweyr Trunk, Floral
    152051, --Blueprint: Elsweyr Trunk, Peaked Embellished
    152050, --Blueprint: Elsweyr Trunk, Peaked Floral
    152048, --Blueprint: Elsweyr Wardrobe, Elegant Wooden
    152047, --Blueprint: Elsweyr Wardrobe, Wide Elegant Wooden
    152058, --Blueprint: Elsweyr Winerack, Cane Mead
    152071, --Blueprint: Elsweyr Writing Desk, Elegant Wooden
    152037, --Pattern: Elsweyr Barstool, Elegant Wooden
    152009, --Pattern: Elsweyr Bed, Blue Four-Poster
    152016, --Pattern: Elsweyr Bed, Elegant Double
    152015, --Pattern: Elsweyr Bed, Elegant Single
    152018, --Pattern: Elsweyr Bed, Rumpled Elegant Double
    152017, --Pattern: Elsweyr Bed, Rumpled Elegant Single
    152014, --Pattern: Elsweyr Bed, Rumpled Quilted Double
    152010, --Pattern: Elsweyr Bed, Yellow Four-Poster
    152101, --Pattern: Elsweyr Carpet, Blossoms on Blue
    152092, --Pattern: Elsweyr Carpet, Botanical Grand
    152094, --Pattern: Elsweyr Carpet, Sandflowers
    152021, --Pattern: Elsweyr Curtains, Wide Maroon
    152095, --Pattern: Elsweyr Rug, Sandflowers
    152029, --Pattern: Elsweyr Tent, Open
    152090, --Pattern: Hakoshae Lantern, Blue
    152091, --Pattern: Hakoshae Lantern, Crimson
    152089, --Pattern: Hakoshae Lantern, Linked Rings
    151972, --Praxis: Elsweyr Bookcase, Ancient Stone Full
    152075, --Praxis: Elsweyr Brazier, Massive
    152074, --Praxis: Elsweyr Brazier, Tall
    152080, --Praxis: Elsweyr Candle, Column
    152112, --Praxis: Elsweyr Fountain, Four Lions
    152079, --Praxis: Elsweyr Lightpost, Ancient Sturdy
    152078, --Praxis: Elsweyr Lightpost, Ancient Tall
    151975, --Praxis: Elsweyr Monument, Ancient Stone Broken
    151997, --Praxis: Elsweyr Pot, Tall
    152007, --Sketch: Elsweyr Incense Burner, Branched Brass
    151992, --Sketch: Elsweyr Steaming Pot, Ceramic
    152002, --Sketch: Elsweyr Sugar Pipe, Gilded
  },
  [198599] =  --Galen Mixed Furnisher's Document
  {
    192533, --Blueprint: Druidic Bookcase, Tall Wood
    192534, --Blueprint: Druidic Cage, Ivy Wood
    192542, --Blueprint: High Isle Dresser, Wood
    192541, --Blueprint: High Isle Nightstand, Wood
    192555, --Design: Druidic Chandelier, Firesong
    192556, --Design: Druidic Gourd Candle, Hanging
    192557, --Design: Druidic Wind Chimes, Gourd
    192529, --Diagram: High Isle Censer, Metal
    192539, --Diagram: High Isle Copper Teapot
    192532, --Pattern: Druidic Bed, Wood Single
    192544, --Pattern: Druidic Tapestry, Woven
    192554, --Pattern: Druidic Wind Chimes, Stone
    192528, --Praxis: Druidic Bed, Ivy Stone Double
    192527, --Praxis: Druidic Bed, Ivy Stone Single
    192521, --Praxis: Druidic Bench, Curved Stone
    192520, --Praxis: Druidic Bench, Ivy Curved Stone
    192519, --Praxis: Druidic Bench, Ivy Stone
    192524, --Praxis: Druidic Bookcase, Tall Stone
    192526, --Praxis: Druidic Dresser, Open Stone
    192523, --Praxis: Druidic End Table, Ivy Stone
    192517, --Praxis: Druidic Gourd Candles, Stone
    192518, --Praxis: Druidic Stone Oven
    192516, --Praxis: Druidic Meditation Stones, Tall
    192515, --Praxis:Druidic Sculpture, Sphere
    192514, --Praxis: Druidic Statue, Planter
    192537, --Praxis: Druidic Table, Stone
    192535, --Praxis: Druidic Trunk, Stone
    192545, --Praxis: Druidic Wall Stone, Fertility
    192547, --Praxis: Druidic Wall Stone, Flame
    192546, --Praxis: Druidic Wall Stone, Spirits
    192543, --Praxis: High Isle Fountain, Wall
  },
  [127106] = -- Hlaalu Journeyman Furnisher's Document
  {
    115768, --Blueprint: Argonian Bookcase, Sturdy
    115757, --Blueprint: Argonian Cage, Bird
    115766, --Blueprint: Argonian Dresser, Sturdy
    115767, --Blueprint: Argonian Shelf, Woven
    115760, --Blueprint: Argonian Snakes in a Basket
    115947, --Blueprint: Breton Desk, Knotwork
    115941, --Blueprint: Breton Hutch, Knotwork
    115948, --Blueprint: Breton Table, Round
    116032, --Blueprint: Dark Elf Bookcase, Sectioned
    116030, --Blueprint: Dark Elf Caravan, Cargo
    116029, --Blueprint: Dark Elf Wagon, Merchant
    118961, --Blueprint: High Elf Chair, Verdant
    116129, --Blueprint: Khajiit Counter, Long Cabinet
    116105, --Blueprint: Khajiit Table, Formal
    116184, --Blueprint: Nord Armoire, Lattice
    116174, --Blueprint: Nord Bookcase, Short Alcove
    116175, --Blueprint: Nord Chair, Braced
    116176, --Blueprint: Nord Counter, Long
    116178, --Blueprint: Nord Stool, Braced
    116181, --Blueprint: Nord Table, Braced
    116182, --Blueprint: Nord Trestle, Braced
    119040, --Blueprint: Orcish Bucket, Cistern
    119053, --Blueprint: Orcish Cabinet, Branded
    119044, --Blueprint: Orcish Pew, Peaked
    119171, --Blueprint: Redguard Cabinet, Inlaid
    119215, --Blueprint: Redguard Candleholder, Polished
    119163, --Blueprint: Redguard Caravan, Practical
    119164, --Blueprint: Redguard Carriage, Merchant
    119168, --Blueprint: Redguard Cask, Sealed
    119175, --Blueprint: Redguard Counter, Corner
    119173, --Blueprint: Redguard Cupboard, Lattice
    119301, --Blueprint: Redguard End Table, Inlaid
    119190, --Blueprint: Redguard End Table, Oasis
    119193, --Blueprint: Redguard Shelf, Arched
    119189, --Blueprint: Redguard Table, Oasis
    115753, --Design: Argonian Totem, Painted Skull
    119032, --Design: Breton Chamberstick, Short
    119470, --Design: Cured Meat Chunk
    119542, --Design: Fish, Medium
    119541, --Design: Fish, Small
    119526, --Design: Goblet, Wine
    116112, --Design: Khajiit Decanter, Amber
    115881, --Design: Wood Elf Pitcher, Chipped
    115773, --Diagram: Argonian Cup, Bordered
    119413, --Diagram: Cauldron of Soup
    116044, --Diagram: Dark Elf Pot, Scaled
    118977, --Diagram: High Elf Carafe, Gilded
    118983, --Diagram: High Elf Lamp, Oil
    119446, --Diagram: Lantern, Hanging
    119063, --Diagram: Orcish Plate, Stone
    119440, --Diagram: Pie Dish, Empty
    119207, --Diagram: Redguard Mug, Full
    119205, --Diagram: Redguard Sconce, Polished
    119177, --Diagram: Redguard Shelf, Barrel
    119186, --Diagram: Redguard Urn, Star
    115784, --Pattern: Argonian Scaleskin, Faded
    115935, --Pattern: Breton Bed, Full
    116050, --Pattern: Dark Elf Carpet, Fungal
    118973, --Pattern: High Elf Carpet, Water-Themed
    118976, --Pattern: High Elf Tapestry, Tree-Themed
    116120, --Pattern: Khajiit Curtains, Moons
    119071, --Pattern: Orcish Banner, Hammer Fist
    119035, --Pattern: Orcish Shelter, Shingled
    119220, --Pattern: Redguard Basket, Closed
    119183, --Pattern: Redguard Bed, Wide Grand
    119225, --Pattern: Redguard Tent, Scaled Flames
    115867, --Pattern: Wood Elf Bladder, Fermenting
    115873, --Pattern: Wood Elf Divider, Relaxed
    115775, --Praxis: Argonian Bowl, Bordered
    115776, --Praxis: Argonian Ramekin, Bordered
    118969, --Praxis: High Elf Trestle, Verdant
    119057, --Praxis: Orcish Trestle, Engraved
  },
  [121364] = -- Hlaalu Master Furnisher's Document
  {
    115827, --Blueprint: Argonian Bark, Painted
    115830, --Blueprint: Argonian Gravestick
    115796, --Blueprint: Argonian Hamper, Woven
    115799, --Blueprint: Argonian Table, Horn
    115973, --Blueprint: Breton Armchair, Padded
    115974, --Blueprint: Breton Cabinet, Knotwork
    115972, --Blueprint: Breton Chair, Padded
    115999, --Blueprint: Breton Cart, Palanquin
    115977, --Blueprint: Breton Coffer, Knotwork
    115980, --Blueprint: Breton Counter, Corner
    115975, --Blueprint: Breton Curio, Knotwork
    115984, --Blueprint: Breton Divider, Folded Knotwork
    115997, --Blueprint: Breton Footlocker, Knotwork
    115983, --Blueprint: Breton Nightstand, Knotwork
    115971, --Blueprint: Breton Sideboard, Knotwork
    115986, --Blueprint: Breton Stool, Padded
    115988, --Blueprint: Breton Table, Formal
    116058, --Blueprint: Dark Elf Bed, Canopy
    116060, --Blueprint: Dark Elf Counter, Block
    116059, --Blueprint: Dark Elf Counter, Corner
    116064, --Blueprint: Dark Elf Divider, Folded
    116061, --Blueprint: Dark Elf Nightstand, Angled
    116057, --Blueprint: Dark Elf Sofa, Angled
    116040, --Blueprint: Dark Elf Table, Tea
    116066, --Blueprint: Dark Elf Trunk, Buckled
    116067, --Blueprint: Dark Elf Wardrobe, Angled
    119483, --Blueprint: Gibbet, Single
    116125, --Blueprint: Khajiit Bed, Canopy
    116132, --Blueprint: Khajiit Table, Round
    116133, --Blueprint: Khajiit Wardrobe, Arched
    118920, --Blueprint: High Elf Armoire, Winged
    118917, --Blueprint: High Elf Bed, Winged Double
    118919, --Blueprint: High Elf Bookcase, Short Winged
    118921, --Blueprint: High Elf Bookcase, Winged
    118927, --Blueprint: High Elf Cabinet, Corner
    118923, --Blueprint: High Elf Chair, Regal Verdant
    118926, --Blueprint: High Elf Counter, Block
    118933, --Blueprint: High Elf Stool, Covered
    119490, --Blueprint: Horn, Ritual
    116127, --Blueprint: Khajiit Bookcase, Arched
    116103, --Blueprint: Khajiit Counter, Faded
    116194, --Blueprint: Nord Bed, Canopy
    116195, --Blueprint: Nord Bookcase, Alcove
    116191, --Blueprint: Nord Cart, Covered
    116198, --Blueprint: Nord Counter, Cabinet
    116197, --Blueprint: Nord Counter, Corner
    116201, --Blueprint: Nord Divider, Folding
    116200, --Blueprint: Nord Nightstand, Braced
    116203, --Blueprint: Nord Table, Formal
    116204, --Blueprint: Nord Table, Game
    116202, --Blueprint: Nord Table, Great
    116205, --Blueprint: Nord Trestle, Tied
    116216, --Blueprint: Nord Trunk, Buckled
    119079, --Blueprint: Orcish Armoire, Peaked
    119080, --Blueprint: Orcish Bed, Peaked
    119081, --Blueprint: Orcish Bookcase, Peaked
    119084, --Blueprint: Orcish Cabinet, Engraved
    119111, --Blueprint: Orcish Candleholder, Horn
    119112, --Blueprint: Orcish Candlestick, Horn
    119075, --Blueprint: Orcish Chair, Peaked
    119086, --Blueprint: Orcish Coffer, Bolted
    119120, --Blueprint: Orcish Cradle, Peaked
    119087, --Blueprint: Orcish Cupboards, Peaked
    119095, --Blueprint: Orcish Divider, Curved
    119091, --Blueprint: Orcish Hutch, Storage
    119100, --Blueprint: Orcish Mug, Horn
    119093, --Blueprint: Orcish Nightstand, Engraved
    119099, --Blueprint: Orcish Stein, Horn
    121369, --Blueprint: Redguard Bed, Full Lattice
    119245, --Blueprint: Redguard Bookcase, Full
    119244, --Blueprint: Redguard Bookcase, Piled
    119286, --Blueprint: Redguard Counter, Bar Island
    119285, --Blueprint: Redguard Counter, Block Island
    119257, --Blueprint: Redguard Cupboard, Sturdy
    119248, --Blueprint: Redguard Desk, Bolted
    119254, --Blueprint: Redguard Divider, Lattice
    119250, --Blueprint: Redguard Nightstand, Bolted
    119258, --Blueprint: Redguard Shelf, Bolted
    119252, --Blueprint: Redguard Table, Formal
    119253, --Blueprint: Redguard Table, Game
    119296, --Blueprint: Redguard Table, Grand Inlaid
    119241, --Blueprint: Redguard Wardrobe, Braced
    119243, --Blueprint: Redguard Wardrobe, Sturdy
    115795, --Design: Argonian Bone Chimes
    115823, --Design: Argonian Light, Stick
    115826, --Design: Argonian Lights, Branch
    115792, --Design: Argonian Skull, Crocodile
    115794, --Design: Argonian Skull, Lizard
    115831, --Design: Argonian Tree of Lights
    115793, --Design: Argonian Totem of the Snake
    116002, --Design: Breton Urn Lid, Striated
    116138, --Design: Khajiit Urn, Amber
    116137, --Design: Khajiit Vial, Amber
    116139, --Design: Khajiit Vessel, Amber
    116193, --Design: Nord Urn, Braided
    119103, --Design: Orcish Bowl, Buffed
    119078, --Design: Orcish Capsule, Sealed
    119104, --Design: Orcish Platter, Serving
    119105, --Design: Orcish Urn, Sealed
    119262, --Design: Redguard Pot, Hanging Mosaic
    119261, --Design: Redguard Pot, Mosaic
    119539, --Design: Sweetroll
    115892, --Design: Wood Elf Bin, Blue Feathers
    115893, --Design: Wood Elf Bin, Feathers
    115902, --Design: Wood Elf Bone Chimes
    115894, --Design: Wood Elf Cask, Painted
    115886, --Design: Wood Elf Censer, Hanging
    115895, --Design: Wood Elf Fish Dish
    115903, --Design: Wood Elf Rack, Dried Fish
    115904, --Design: Wood Elf Rack, Dried Meat
    115888, --Design: Wood Elf Rack, Meat
    115901, --Design: Wood Elf Skull and Bones
    115889, --Design: Wood Elf Totem, Framed
    115890, --Design: Wood Elf Totem, Skull
    115891, --Design: Wood Elf Trough, Slop
    116010, --Diagram: Breton Candelabra, Formal
    116004, --Diagram: Breton Lamp, Hanging
    115995, --Diagram: Breton Lamp, Oil
    116008, --Diagram: Breton Sconce, Floor
    116009, --Diagram: Breton Candle, Grand
    116011, --Diagram: Breton Sconce, Wall
    116007, --Diagram: Breton Streetlight, Full
    116005, --Diagram: Breton Streetlight, Full Stone
    119518, --Diagram: Cage, Wild Animal
    116080, --Diagram: Dark Elf Candle, Votive Tray
    116079, --Diagram: Dark Elf Candelabra, Angled
    116077, --Diagram: Dark Elf Cauldron, Ringed
    116068, --Diagram: Dark Elf Kettle Cooker
    116075, --Diagram: Dark Elf Thurible, Caged
    118940, --Diagram: High Elf Basin, Standing
    118952, --Diagram: High Elf Candelabra, Winged
    118953, --Diagram: High Elf Crest, Winged
    118946, --Diagram: High Elf Goblet, Winged
    121309, --Diagram: High Elf Medal, Winged
    118941, --Diagram: High Elf Platter, Winged
    118939, --Diagram: High Elf Pot, Hanging
    116144, --Diagram: Khajiit Brazier, Hanging
    116146, --Diagram: Khajiit Candle-Filled Lamp
    116140, --Diagram: Khajiit Candles, Clawfoot
    116128, --Diagram: Khajiit Footlocker, Arched
    116145, --Diagram: Khajiit Sconce, Spiked
    116213, --Diagram: Nord Brazier, Hanging
    116209, --Diagram: Nord Candle, Antler
    116210, --Diagram: Nord Chandelier, Antler
    116192, --Diagram: Nord Chest, Latched
    116211, --Diagram: Nord Streetlamps, Stone
    119114, --Diagram: Orcish Brazier, Bordered
    119117, --Diagram: Orcish Brazier, Floor
    119115, --Diagram: Orcish Brazier, Hanging
    119110, --Diagram: Orcish Cauldron, Sealed
    119123, --Diagram: Orcish Chandelier, Spiked
    119101, --Diagram: Orcish Knife, Kitchen
    119118, --Diagram: Orcish Sconce, Bordered
    119119, --Diagram: Orcish Sconce, Scrolled
    119072, --Diagram: Orcish Strongbox, Buckled
    119109, --Diagram: Orcish Vessel, Sealed
    119288, --Diagram: Redguard Brazier, Enchanted
    119230, --Diagram: Redguard Brazier, Garish
    119279, --Diagram: Redguard Candelabra, Polished
    119278, --Diagram: Redguard Candelabra, Twisted
    119278, --Diagram: Redguard Candelabra, Twisted
    121373, --Diagram: Redguard Censer, Hanging Bulb
    121374, --Diagram: Redguard Censer, Hanging Disc
    119269, --Diagram: Redguard Chalice, Full
    121305, --Diagram: Redguard Chandelier, Dark
    121304, --Diagram: Redguard Chandelier, Grated
    119281, --Diagram: Redguard Chandelier, Polished Grated
    119251, --Diagram: Redguard Pot, Hanging Garish
    119277, --Diagram: Redguard Streetlamps, Full
    115806, --Formula: Argonian Pestle, Bone
    119484, --Formula: Bottle, Elixir
    115982, --Formula: Breton Mirror, Knotwork
    119485, --Formula: Bottle, Liquor
    119488, --Formula: Bottle, Wine
    118947, --Formula: High Elf Goblet, Glass
    119121, --Formula: Orcish Mirror, Peaked
    119273, --Formula: Redguard Bottle, Delicate
    119303, --Formula: Redguard Bottle, Stained Glass
    119275, --Formula: Redguard Decanter, Delicate
    119302, --Formula: Redguard Decanter, Glass
    119270, --Formula: Redguard Hourglass of Desert Sands
    119309, --Formula: Redguard Lamp, Caged
    119310, --Formula: Redguard Lantern, Caged
    119311, --Formula: Redguard Lantern, Caged Stand
    119308, --Formula: Redguard Lantern, Cannister
    119276, --Formula: Redguard Lantern, Delicate
    119249, --Formula: Redguard Vanity, Bolted
    119304, --Formula: Redguard Vial, Stained Glass
    115818, --Pattern: Argonian Banners, Frilled
    115819, --Pattern: Argonian Banner, Half Hands
    115817, --Pattern: Argonian Bedroll, Woven
    115787, --Pattern: Argonian Canopy, Frilled
    115788, --Pattern: Argonian Canopy, Skull
    115800, --Pattern: Argonian Curtain of Smoke
    115801, --Pattern: Argonian Curtain of the Nest
    115816, --Pattern: Argonian Divider, Stretched
    115802, --Pattern: Argonian Drum, Ceremonial
    115821, --Pattern: Argonian Lanterns, String
    115807, --Pattern: Argonian Seat of Authority
    115815, --Pattern: Argonian Seat of Comfort
    115808, --Pattern: Argonian Seat of Honor
    115970, --Pattern: Breton Bed, Canopy
    115992, --Pattern: Breton Carpet, Bordered
    115969, --Pattern: Breton Curtains, Window
    115976, --Pattern: Breton Drapes, Grand
    115990, --Pattern: Breton Rug, Bordered
    115991, --Pattern: Breton Runner, Bordered
    115994, --Pattern: Breton Tablecloth, Blue
    115996, --Pattern: Breton Tablecloth, Striped
    116001, --Pattern: Breton Tapestry, Boughs
    116000, --Pattern: Breton Tapestry, Vines
    116062, --Pattern: Dark Elf Pillow, Cushion
    116063, --Pattern: Dark Elf Pillow, Roll
    116051, --Pattern: Dark Elf Rug, Fungal
    116072, --Pattern: Dark Elf Rug, Striated
    121308, --Pattern: High Elf Banner, Gilded
    118918, --Pattern: High Elf Bench, Covered
    118942, --Pattern: High Elf Carpet, Eagle
    118931, --Pattern: High Elf Divider, Carved
    118943, --Pattern: High Elf Tapestry, Eagle
    116126, --Pattern: Khajiit Couch, Padded
    116131, --Pattern: Khajiit Divider, Folding
    116135, --Pattern: Khajiit Drapes, Grand
    116142, --Pattern: Khajiit Pillow, Roll
    116134, --Pattern: Khajiit Rug, Moons
    116143, --Pattern: Khajiit Rug, Sun
    116141, --Pattern: Khajiit Sofa, Padded
    116207, --Pattern: Nord Banner, Knotwork
    116208, --Pattern: Nord Tapestry, Ship
    116206, --Pattern: Nord Rug, Bearskin
    119102, --Pattern: Orcish Backpack
    119106, --Pattern: Orcish Tapestry, Axe
    119107, --Pattern: Orcish Tapestry, Heroes
    121366, --Pattern: Orcish Tapestry, Hunt
    119108, --Pattern: Orcish Tapestry, Sword
    119122, --Pattern: Orcish Tapestry, War
    119246, --Pattern: Redguard Armchair, Starry
    119238, --Pattern: Redguard Bed, Wide Canopy
    119240, --Pattern: Redguard Bench, Padded
    119290, --Pattern: Redguard Canopy, Stars
    119266, --Pattern: Redguard Carpet, Mirage
    119247, --Pattern: Redguard Chair, Starry
    119239, --Pattern: Redguard Couch, Slatted
    119256, --Pattern: Redguard Footstool, Starry
    119265, --Pattern: Redguard Mat, Desert
    119306, --Pattern: Redguard Mat, Mirage
    119307, --Pattern: Redguard Mat, Starburst
    119298, --Pattern: Redguard Pillow Roll, Desert Flame
    119292, --Pattern: Redguard Pillow, Florid Flames
    119234, --Pattern: Redguard Pillow, Florid Oasis
    119293, --Pattern: Redguard Pillow, Florid Sunset
    119233, --Pattern: Redguard Pillow, Oasis
    119232, --Pattern: Redguard Pillow, Sunset
    119264, --Pattern: Redguard Runner, Oasis
    119255, --Pattern: Redguard Stool, Starry
    119267, --Pattern: Redguard Tapestry, Oasis
    119312, --Pattern: Redguard Tapestry, Starry
    119299, --Pattern: Redguard Throw Pillow, Desert Flame
    119236, --Pattern: Redguard Throw Pillow, Oasis
    115900, --Pattern: Wood Elf Bedding, Padded
    115899, --Pattern: Wood Elf Canopy, Spine
    115897, --Pattern: Wood Elf Tapestry, Deer
    115896, --Pattern: Wood Elf Tapestry, Painted
    115898, --Pattern: Wood Elf Tapestry, Vine
    115803, --Praxis: Argonian Bowl, Ritual
    115825, --Praxis: Argonian Brazier, Mud
    115791, --Praxis: Argonian Chest, Carved
    115804, --Praxis: Argonian Jug, Ritual
    115824, --Praxis: Argonian Lamp, Mud
    115810, --Praxis: Argonian Mortar, Bone
    115811, --Praxis: Argonian Pedestal, Altar
    115805, --Praxis: Argonian Pot, Ritual
    115828, --Praxis: Argonian Relic, Basin
    115814, --Praxis: Argonian Relic, Serpent
    115813, --Praxis: Argonian Relic, Small Serpent
    116003, --Praxis: Breton Urn, Striated
    116006, --Praxis: Breton Vase, Delicate
    118922, --Praxis: High Elf Dresser, Corner
    118929, --Praxis: High Elf Dresser, Winged
    118934, --Praxis: High Elf End Table, Winged
    118932, --Praxis: High Elf Table, Tea
    118935, --Praxis: High Elf Table, Winged Formal
    118936, --Praxis: High Elf Table, Winged Kitchen
    118937, --Praxis: High Elf Trestle, Winged
    118954, --Praxis: High Elf Streetlight, Stone
    121203, --Praxis: Khajiit Brazier, Enchanted
    119089, --Praxis: Orcish Cabinet, Bedside
    119088, --Praxis: Orcish Dresser, Engraved
    119085, --Praxis: Orcish Hutch, Engraved
    119083, --Praxis: Orcish Sideboard, Engraved
    119096, --Praxis: Orcish Table, Game
    119260, --Praxis: Redguard Enclosure, Arc
    119284, --Praxis: Redguard Firepit, Stone
    119274, --Praxis: Redguard Jar, Baroque
    119271, --Praxis: Redguard Jar, Oasis
    119272, --Praxis: Redguard Vase, Baroque
    121371, --Praxis: Wood Elf Hearth, Forest
  },
  [194430] =  --High Isle Mixed Furnisher's Document
  {
    188158, --Blueprint: High Isle Chair, Sturdy
    188150, --Blueprint: High Isle Bench, Padded
    188159, --Blueprint: High Isle Bench, Sturdy
    188168, --Blueprint: High Isle Bookcase, Carved Filled
    188151, --Blueprint: High Isle Chair, Ornate
    188158, --Blueprint: High Isle Chair, Sturdy
    188156, --Blueprint: High Isle Counter, Sturdy
    188181, --Blueprint: High Isle End Table, Carved
    188167, --Blueprint: High Isle Nightstand, Ornate
    188176, --Blueprint: High Isle Plate, Compass Rose Setting
    188157, --Blueprint: High Isle Stool, Sturdy
    188172, --Blueprint: High Isle Streetlight, Paired
    188152, --Blueprint: High Isle Table, Ornate
    188155, --Blueprint: High Isle Table, Sturdy
    188166, --Blueprint: High Isle Trunk, Sturdy
    188169, --Blueprint: High Isle Bookcase, Wide Carved Filled
    188180, --Blueprint: High Isle Dresser, Carved
    188160, --Blueprint: High Isle Stool, Cushioned
    188153, --Blueprint: High Isle Table, Compass Rose
    188154, --Blueprint: High Isle Tea Table, Round Wheel
    188165, --Blueprint: High Isle Trunk, Ornate
    188147, --Blueprint: High Isle Wardrobe, Compass Rose
    188177, --Design: High Isle Crab, Steamed
    188179, --Design: High Isle Mussel, Steamed Pile
    188178, --Design: High Isle Crab, Steamed Pile
    188171, --Diagram: High Isle Brazier, Standing
    188192, --Diagram: High Isle Lantern, Table
    188174, --Diagram: High Isle Sconce, Glass
    188186, --Diagram: High Isle Mirror, Standing
    188173, --Diagram: High Isle Sconce, Ornate
    188175, --Diagram: High Isle Serving Platter, Silver
    188184, --Formula: High Isle Herb Rack, Ladder
    188145, --Pattern: High Isle Bed, Canopy Full
    188182, --Pattern: High Isle Carpet, Ballroom
    188187, --Sketch: High Isle Wall Mirror, Gilded
  },
  [181612] =  --Markarth Mixed Furnisher's Document
  {
    171489, --Blueprint: Dwarven Wall Lamp, Reachfolk Adorned
    171487, --Blueprint: Reachmen Chandelier, Gnarled
    171488, --Blueprint: Reachmen Chandelier, Shaded
    171529, --Blueprint: Reachmen Pergola, Ivy
    171511, --Design: Dwarven Serving Dish, Vegetable Soup
    171510, --Design: Dwarven Dinner Bowl, Hearty Stew
    171512, --Design: Dwarven Plate, Full Breakfast
    171503, --Diagram: Dwarven Amphora, Ornate Polished
    171484, --Diagram: Dwarven Brazier, Square Polished
    171492, --Diagram: Dwarven Corner Bench, Ornate Polished
    171514, --Diagram: Dwarven Desk, Ornate Polished
    171498, --Diagram: Dwarven Divider, Ornate Polished
    171505, --Diagram: Dwarven Kettle, Ornate Polished
    171483, --Diagram: Dwarven Lamp, Conal Frustum Cage
    171482, --Diagram: Dwarven Lamp, Cylinder Cage
    171519, --Diagram: Dwarven Low Table, Ornate Polished
    171501, --Diagram: Dwarven Relief, Connected Circles
    171517, --Diagram: Dwarven Sideboard, Granite Polished
    171515, --Diagram: Dwarven Table, Grand Polished
    171526, --Diagram: Dwarven Wardrobe, Ornate Polished
    171493, --Diagram: Dwarven Chair, Ornate Polished
    171508, --Diagram: Dwarven Cooking Implements, Hanging
    171491, --Diagram: Dwarven Pew, Ornate Polished
    171504, --Diagram: Dwarven Pot, Polished
    171481, --Diagram: Dwarven Potted Plant, Polished Vase
    171502, --Diagram: Dwarven Relief, Tracks
    171509, --Diagram: Dwarven Strainer, Kitchen
    171486, --Diagram: Dwarven Table Lamp, Polished Dome
    171523, --Diagram: Dwarven Trunk, Ornate Polished
    171494, --Pattern: Dwarven Bed, Reach Furs
    171496, --Pattern: Dwarven Bed, Reach Furs Canopy
    171495, --Pattern: Dwarven Bed, Reach Furs Double
    171490, --Praxis: Dwarven Bench, Ornate Granite
    171527, --Praxis: Dwarven Bookcase, Granite
    171528, --Praxis: Dwarven Bookcase, Granite Filled
    171513, --Praxis: Dwarven Counter, Granite
    171497, --Praxis: Dwarven Divider, Ornate Granite
    171522, --Praxis: Dwarven Dresser, Granite
    171520, --Praxis: Dwarven End Table, Columnar Granite
    171521, --Praxis: Dwarven Nightstand, Granite
    171516, --Praxis: Dwarven Table, Granite
    171518, --Praxis: Dwarven Table, Granite Kitchen
    171524, --Praxis: Dwarven Wall Cabinet, Granite
    171799, --Praxis: Markarth Archway, Stone
    171790, --Praxis: Markarth Fireplace, Stone
    171781, --Praxis: Markarth Floor, Circular
    171783, --Praxis: Markarth Floor, Large Oval
    171785, --Praxis: Markarth Floor, Large Rectangle
    171784, --Praxis: Markarth Floor, Large Square
    171782, --Praxis: Markarth Floor, Square
    171788, --Praxis: Markarth Pillar, Stone
    171793, --Praxis: Markarth Platform, Bordered Square
    171792, --Praxis: Markarth Platform, Square
    171796, --Praxis: Markarth Stairway, Wide Stone
    171800, --Praxis: Markarth Tower, Stone
    171798, --Praxis: Markarth Walkway, Metal Trim
    171791, --Praxis: Markarth Wall, Windowed Stone
    171499, --Sketch: Dwarven Mirror, Polished
  },
  [153888] =  --Murkmire Mixed Furnisher's Document
  {
    145992, --Blueprint: Murkmire Bed, Carved
    145980, --Blueprint: Murkmire Bonding Chimes, Domed
    146016, --Blueprint: Murkmire Bonding Chimes, Simple
    145994, --Blueprint: Murkmire Chair, Woven
    145996, --Blueprint: Murkmire Counter, Cabinet
    146006, --Blueprint: Murkmire Gate, Arched
    146005, --Blueprint: Murkmire Platform, Reed
    146002, --Blueprint: Murkmire Ramp, Marshwood
    146004, --Blueprint: Murkmire Ramp, Reed
    146001, --Blueprint: Murkmire Shelf, Woven Hanging
    146000, --Blueprint: Murkmire Shelves, Woven
    145998, --Blueprint: Murkmire Table, Woven
    146008, --Blueprint: Murkmire Totem Post, Carved
    146017, --Blueprint: Murkmire Totem, Wolf-Lizard
    145995, --Blueprint: Murkmire Trunk, Leatherbound
    146009, --Blueprint: Murkmire Wall, Corner Curve
    146007, --Blueprint: Murkmire Wall, Straight
    145993, --Blueprint: Murkmire Wardrobe, Woven
    145971, --Design: Bowl of Worms, Large
    145988, --Design: Murkmire Candlepost, Driftwood
    145987, --Design: Murkmire Candlepost, Timber
    145989, --Design: Murkmire Candles, Bone Group
    145968, --Design: Murkmire Pot, Large Carved
    145960, --Diagram: Murkmire Brazier, Bowl
    145986, --Formula: Murkmire Candle, Standing Shell
    145982, --Formula: Murkmire Lamp, Hanging Bottle
    145983, --Formula: Murkmire Lamp, Hanging Conch
    145981, --Formula: Murkmire Lantern, Covered
    145984, --Formula: Murkmire Sconce, Shell
    146011, --Pattern: Murkmire Rug, Hist Gathering
    146012, --Pattern: Murkmire Rug, Supine Turtle
    146010, --Pattern: Murkmire Tapestry, Hist Gathering
    145947, --Praxis: Murkmire Bed, Enclosed
    145945, --Praxis: Murkmire Bench, Wide
    145955, --Praxis: Murkmire Bookcase
    145956, --Praxis: Murkmire Bookcase, Full
    145951, --Praxis: Murkmire Bookcase, Grand
    145952, --Praxis: Murkmire Bookcase, Grand Full
    145950, --Praxis: Murkmire Brazier, Engraved
    145962, --Praxis: Murkmire Hearth Shrine, Sithis Coiled
    145963, --Praxis: Murkmire Hearth Shrine, Sithis Looming
    145961, --Praxis: Murkmire Hearth Shrine, Sithis Rearing
    145958, --Praxis: Murkmire Pedestal, Winged
    145957, --Praxis: Murkmire Platform, Sectioned
    145953, --Praxis: Murkmire Sarcophagus, Empty
    145954, --Praxis: Murkmire Sarcophagus Lid
    145967, --Praxis: Murkmire Shrine, Sithis Coiled
    145966, --Praxis: Murkmire Shrine, Sithis Figure
    145965, --Praxis: Murkmire Shrine, Sithis Rearing
    145964, --Praxis: Murkmire Shrine, Sithis Relief
    145949, --Praxis: Murkmire Table, Engraved
    145959, --Praxis: Murkmire Totem, Beacon
    145979, --Praxis: Murkmire Wall, Stone
  },
  [134684] =  --Morrowind Journeyman Furnisher's Document
  {
    127002, --Blueprint: Ashlander Cup, Empty
    127003, --Blueprint: Ashlander Cup, Mazte
    126916, --Blueprint: Dres Sideboard, Display
    126917, --Blueprint: Dres Table, Kitchen
    126915, --Blueprint: Dres Trestle, Corridor
    126909, --Blueprint: Hlaalu Bench, Polished
    126932, --Blueprint: Hlaalu Bookcase, Empty
    126934, --Blueprint: Hlaalu Cabinet, Open
    126914, --Blueprint: Hlaalu Chair, Polished
    126933, --Blueprint: Hlaalu Cupboard, Open
    126935, --Blueprint: Hlaalu Dresser, Open
    126948, --Blueprint: Hlaalu Dresser, Scroll Drawers
    126977, --Blueprint: Hlaalu Dresser, Scroll Rack
    126907, --Blueprint: Hlaalu Settee, Polished
    126975, --Blueprint: Hlaalu Shelf, Long
    126950, --Blueprint: Indoril End Table, Rounded
    126976, --Blueprint: Indoril Shelf, Long
    126931, --Blueprint: Redoran Bench, Sanded
    126940, --Blueprint: Redoran Chair, Sanded
    126951, --Blueprint: Redoran End Table, Sanded
    127068, --Blueprint: Redoran Fork, Wooden
    127069, --Blueprint: Redoran Knife, Wooden
    126929, --Blueprint: Redoran Settee, Sanded
    126967, --Blueprint: Redoran Sideboard, Display
    127070, --Blueprint: Redoran Spoon, Wooden
    126968, --Blueprint: Redoran Table, Kitchen
    126966, --Blueprint: Redoran Trestle, Corridor
    126999, --Design: Ashlander Platter, Bread and Cheese
    126998, --Design: Ashlander Platter, Ceramic
    126996, --Design: Dres Bowl, Empty
    126997, --Design: Dres Bowl, Saltrice Mash
    127083, --Design: Dres Candles, Meditation
    127004, --Design: Dres Cup, Empty Greef
    127005, --Design: Dres Cup, Greef
    126994, --Design: Redoran Bowl, Empty
    126995, --Design: Redoran Bowl, Saltrice Mash
    127000, --Diagram: Dres Cauldron, Floral Banded
    127104, --Diagram: Hlaalu Boxes, Compact
    126991, --Diagram: Indoril Bellows, Practical
    127074, --Diagram: Indoril Brazier, Knotwork
    127086, --Diagram: Indoril Chandelier, Knotwork
    126962, --Diagram: Indoril Chest, Fortified
    126963, --Diagram: Indoril Footlocker, Fortified
    127017, --Formula: Dres Censer, Chains
    127084, --Formula: Indoril Candelabra, Shrine
    127090, --Formula: Indoril Lantern, Hanging
    127087, --Formula: Indoril Streetlight, Brick
    127018, --Formula: Redoran Incense Holder, Ceramic Pan
    127032, --Pattern: Dres Carpet, Fertile Peat
    127056, --Pattern: Dres Tapestry, Vines
    127059, --Pattern: Hlaalu Banner, Floral
    126921, --Pattern: Hlaalu Bed, Double Pillow
    126920, --Pattern: Hlaalu Bed, Single Pillow
    127031, --Pattern: Hlaalu Carpet, Garden Moss
    127058, --Pattern: Hlaalu Tapestry, Floral
    127021, --Pattern: Hlaalu Towels, Folded
    126924, --Pattern: Redoran Bed, Double Pillow
    126923, --Pattern: Redoran Bed, Single Pillow
    127030, --Pattern: Redoran Carpet, Volcanic Ash
    127053, --Pattern: Redoran Mantle Cloth, Crimson Coverlet
    127067, --Praxis: Dres Jar, Stoneflower
    127062, --Praxis: Dres Teapot, Ceramic
    127064, --Praxis: Hlaalu Jar, Garden Moss
    127019, --Praxis: Indoril Incense Cup, Silver
    127066, --Praxis: Redoran Jar, Jazbay
  },
  [134683] =  --Morrowind Master Furnisher's Document
  {
    126960, --Blueprint: Dres Divider, Chains
    126961, --Blueprint: Dres Divider, Honeycomb
    126959, --Blueprint: Dres Divider, Screen
    126912, --Blueprint: Hlaalu Armchair, Mossy Cushion
    126913, --Blueprint: Hlaalu Armchair, Polished
    126942, --Blueprint: Hlaalu Bookcase, Orderly
    127048, --Blueprint: Hlaalu Box, Trinket
    126955, --Blueprint: Hlaalu Cabinet, Clerk
    126946, --Blueprint: Hlaalu Cabinet of Drawers, Clerk
    126972, --Blueprint: Hlaalu Chest, Secure
    126943, --Blueprint: Hlaalu Cupboard, Formal
    126944, --Blueprint: Hlaalu Desk, Scholar's
    126953, --Blueprint: Hlaalu End Table, Formal Scales
    126952, --Blueprint: Hlaalu End Table, Formal Turtle
    126971, --Blueprint: Hlaalu Footlocker, Secure
    126958, --Blueprint: Hlaalu Nightstand, Formal
    126957, --Blueprint: Hlaalu Nightstand, Scholar's
    126945, --Blueprint: Hlaalu Sideboard, Low Cabinet
    126947, --Blueprint: Hlaalu Sideboard, Scholar's
    126949, --Blueprint: Hlaalu Sideboard, Scribe's
    126918, --Blueprint: Hlaalu Table, Formal Floral
    126919, --Blueprint: Hlaalu Table, Formal Turtle
    126941, --Blueprint: Hlaalu Wardrobe, Formal
    126939, --Blueprint: Redoran Armchair, Sanded
    126969, --Blueprint: Redoran Table, Formal Floral
    126970, --Blueprint: Redoran Table, Formal Turtle
    127006, --Design: Dres Cup, Empty Sujamma
    127007, --Design: Dres Cup, Sujamma
    127080, --Design: Indoril Candelabra, Shrine Chamber
    127085, --Design: Indoril Candelabra, Temple
    127079, --Design: Indoril Candelabra, Temple Chamber
    127078, --Design: Indoril Candle, Temple
    127008, --Design: Redoran Cup, Empty
    127009, --Design: Redoran Cup, Mazte
    127047, --Diagram: Hlaalu Cannister, Trinket
    127088, --Diagram: Hlaalu Sconce, Vellum
    127049, --Diagram: Indoril Box, Trinket
    127075, --Diagram: Indoril Brazier, Cauldron
    127076, --Diagram: Indoril Brazier, Kettle
    127077, --Diagram: Indoril Brazier, Pedestal
    127046, --Diagram: Indoril Cannister, Trinket
    126965, --Diagram: Indoril Cassone, Sealed
    127012, --Diagram: Indoril Platter, Floral
    126964, --Diagram: Indoril Vault, Sealed
    127014, --Diagram: Redoran Incense Holder, Mesh
    127020, --Diagram: Redoran Incense Pot, Beastly
    127022, --Diagram: Redoran Plate, Floral
    127023, --Diagram: Redoran Plate, Meal
    127050, --Diagram: Redoran Steamer, Iron
    127024, --Diagram: Redoran Tray, Floral
    127101, --Diagram: Velothi Brazier, Temple
    127016, --Formula: Dres Incense Stand, Chains
    127092, --Formula: Hlaalu Lantern, Classic Vellum
    127093, --Formula: Hlaalu Lantern, Modest Vellum
    127091, --Formula: Hlaalu Lantern, Oversized Vellum
    126956, --Formula: Hlaalu Mirror, Standing
    127089, --Formula: Hlaalu Streetlight, Vellum
    127082, --Formula: Indoril Sconce, Shrine
    127081, --Formula: Indoril Sconce, Temple
    127037, --Pattern: Dres Rug, Chains
    127036, --Pattern: Dres Runner, Chains
    126922, --Pattern: Hlaalu Bed, Canopy
    126908, --Pattern: Hlaalu Bench, Mossy Cushion
    126906, --Pattern: Hlaalu Settee, Mossy Cushion
    126910, --Pattern: Hlaalu Stool, Mossy Cushion
    127071, --Pattern: Indoril Banner, Almalexia
    127072, --Pattern: Indoril Banner, Sotha Sil
    127073, --Pattern: Indoril Banner, Vivec
    127028, --Pattern: Indoril Carpet, Almalexia
    127029, --Pattern: Indoril Carpet, Grand Almalexia
    127041, --Pattern: Indoril Carpet, Grand Sotha Sil
    127045, --Pattern: Indoril Carpet, Grand Vivec
    127040, --Pattern: Indoril Carpet, Sotha Sil
    127044, --Pattern: Indoril Carpet, Vivec
    127027, --Pattern: Indoril Rug, Almalexia
    127039, --Pattern: Indoril Rug, Sotha Sil
    127043, --Pattern: Indoril Rug, Vivec
    127026, --Pattern: Indoril Runner, Almalexia
    127038, --Pattern: Indoril Runner, Sotha Sil
    127042, --Pattern: Indoril Runner, Vivec
    127057, --Pattern: Indoril Tapestry, Almalexia
    127060, --Pattern: Indoril Tapestry, Sotha Sil
    127061, --Pattern: Indoril Tapestry, Vivec
    126938, --Pattern: Redoran Armchair, Fungal Cushion
    126925, --Pattern: Redoran Bed, Canopy
    126930, --Pattern: Redoran Bench, Fungal Cushion
    127051, --Pattern: Redoran Mantle Cloth, Crimson Cover
    126928, --Pattern: Redoran Settee, Fungal Cushion
    126936, --Pattern: Redoran Stool, Fungal Cushion
    127054, --Pattern: Redoran Table Runner, Gilded Ochre
    126901, --Praxis: Hlaalu Amphora, Sealed Orichalcum
    126905, --Praxis: Hlaalu Cannister, Sealed Azurite
    127015, --Praxis: Hlaalu Censer, Mesh
    126900, --Praxis: Hlaalu Jar, Sealed Malachite
    127065, --Praxis: Hlaalu Vase, Gilded
    126902, --Praxis: Redoran Amphora, Sealed Marble
    126904, --Praxis: Redoran Urn, Dusky Marble
    126903, --Praxis: Redoran Urn, Pale Marble
    127099, --Praxis: Telvanni Arched Light, Organic Azure
    126980, --Praxis: Telvanni Armchair, Organic
    126978, --Praxis: Telvanni Bed, Organic
    126986, --Praxis: Telvanni Bookcase, Organic
    127097, --Praxis: Telvanni Candelabra, Organic
    126979, --Praxis: Telvanni Chair, Organic
    126984, --Praxis: Telvanni Desk, Organic
    126985, --Praxis: Telvanni End Table, Organic
    127096, --Praxis: Telvanni Lamp, Organic Azure
    127098, --Praxis: Telvanni Lantern, Organic Azure
    126983, --Praxis: Telvanni Nightstand, Organic
    127100, --Praxis: Telvanni Sconce, Organic Azure
    126987, --Praxis: Telvanni Shelves, Organic
    126982, --Praxis: Telvanni Sofa, Organic
    126988, --Praxis: Telvanni Stool, Organic
    127055, --Praxis: Telvanni Table Runner, Bordered Azure
    127052, --Praxis: Telvanni Table Runner, Gilded Azure
    126989, --Praxis: Telvanni Table, Organic Game
    126990, --Praxis: Telvanni Table, Organic Grand
    126981, --Praxis: Telvanni Throne, Organic
    127102, --Praxis: Tribunal Tablet of Almalexia
  },
--  [204501] =  --Necrom Journeyman Furnisher's Document
--  {
--  },
  [204500] =  --Necrom Master Furnisher's Document
  {
    197560, --Blueprint: Necrom Bench, Elegant
    197550, --Blueprint: Necrom Bookcase, Elegant Grand
    197630, --Blueprint: Necrom Bookcase, Elegant Grand Filled
    197629, --Blueprint: Necrom Bookcase, Elegant Tall Filled
    197581, --Blueprint: Telvanni Wardrobe, Fungal
    197578, --Design: Necrom Incense, Mushroom Offering
    197585, --Design: Telvanni Dresser, Large Fungal
    197693, --Diagram: Necrom Chandelier, Elegant
    197564, --Diagram: Necrom Firepit, Elegant
    197572, --Diagram: Necrom Hanging Flowers, Elegant
    197576, --Diagram: Necrom Ossuary, Plated
    197593, --Formula: Telvanni Water Jug, Fungal
    197554, --Pattern: Necrom Bed, Elegant Double
    197614, --Pattern: Necrom Carpet, Large
    197579, --Pattern: Telvanni Bed, Fungal Double
    197631, --Praxis: Apocrypha Bookcase, Tall Marble Filled
    197608, --Praxis: Apocrypha Sconce, Spiral
    197569, --Praxis: Necrom Vase, Elegant Rounded Floral
    197557, --Sketch: Necrom Mirror, Elegant Standing
  },
  [171753] =  --Skyrim Journeyman Furnisher's Document
  {
    166921, --Blueprint: Solitude Backpack, Basket
    166919, --Blueprint: Solitude Basket, Centerpiece
    166920, --Blueprint: Solitude Basket, Ornate
    166918, --Blueprint: Solitude Basket, Wicker Wide
    166849, --Blueprint: Solitude Cabinet, Ornate Wall
    166865, --Blueprint: Solitude Cabinet, Rustic Filled
    166832, --Blueprint: Solitude Dresser, Rustic
    166862, --Blueprint: Solitude Jewelry Box, Wolf's-Head
    166848, --Blueprint: Solitude Nightstand, Noble Cabinet
    166810, --Blueprint: Solitude Pew, Sturdy Long
    166916, --Blueprint: Solitude Picnic Basket, Wicker
    166824, --Blueprint: Solitude Table, Round Small
    166830, --Blueprint: Solitude Wardrobe, Rustic
    166931, --Design: Solitude Bowl, Berries
    166930, --Design: Solitude Bowl, Mushrooms
    166944, --Design: Solitude Bread, Floral Pattern
    166947, --Design: Solitude Bread, Rustic Loaf
    166943, --Design: Solitude Breakfast, Sausages and Ham
    166939, --Design: Solitude Camping Pot, Fish Stew
    166936, --Design: Solitude Dinner Bowl, Hearty Stew
    166938, --Design: Solitude Dinner Bowl, Vegetable Soup
    166954, --Design: Solitude Drying Rack, Stockfish
    166895, --Diagram: Solitude Hand-Drill, Simple
    166925, --Diagram: Solitude Frying Pan, Long-Handled
    166907, --Diagram: Solitude Pot, Stout Metal
    166860, --Diagram: Solitude Trunk, Knotwork
    166891, --Pattern: Solitude Bed, Rustic Bearskin Single
    166794, --Pattern: Solitude Carpet, Small Plush
    166898, --Pattern: Solitude Patching Kit, Well-Worn
    166787, --Pattern: Solitude Rug, Cowhide
    166793, --Pattern: Solitude Rug, Knotwork
    166788, --Pattern: Solitude Rug, Snow Bear
    166951, --Sketch: Solitude Goblet, Noble
    166911, --Sketch: Solitude Serving Bowl, Verdigris
  },
  [171754] =  --Skyrim Master Furnisher's Document
  {
    166799, --Blueprint: Solitude Armchair, High-Backed Noble
    166800, --Blueprint: Solitude Armchair, Noble
    166801, --Blueprint: Solitude Armchair, Ornate
    166802, --Blueprint: Solitude Armchair, Ornate Low
    166876, --Blueprint: Solitude Bookcase, Backless
    166877, --Blueprint: Solitude Bookcase, Backless Filled
    166875, --Blueprint: Solitude Bookcase, Narrow Noble Filled
    166879, --Blueprint: Solitude Bookcase, Narrow Open Filled
    166872, --Blueprint: Solitude Bookcase, Noble
    166870, --Blueprint: Solitude Bookcase, Noble Cabinet
    166871, --Blueprint: Solitude Bookcase, Noble Cabinet Filled
    166873, --Blueprint: Solitude Bookcase, Noble Filled
    166881, --Blueprint: Solitude Cabinet, Narrow Noble Filled
    166844, --Blueprint: Solitude Chest of Drawers, Noble
    166845, --Blueprint: Solitude Chest of Drawers, Wide Noble
    166842, --Blueprint: Solitude Desk, Ornate
    166882, --Blueprint: Solitude Display Shelf, Noble
    166959, --Blueprint: Solitude Display Shelf, Noble Filled
    166899, --Blueprint: Solitude Game, Warrior and the Wolf
    166851, --Blueprint: Solitude Mirror, Noble Full-Length
    166817, --Blueprint: Solitude Pew, Noble Long
    166818, --Blueprint: Solitude Pew, Ornate
    166816, --Blueprint: Solitude Pew, Ornate Long
    166859, --Blueprint: Solitude Strongbox, Iron Hunt Relief
    166836, --Blueprint: Solitude Table, Circular Ornate
    166835, --Blueprint: Solitude Table, Grand Noble
    166839, --Blueprint: Solitude Table, Square Ornate
    166838, --Blueprint: Solitude Table, Square Ornate Low
    166852, --Blueprint: Solitude Wall Mirror, Noble
    166843, --Blueprint: Solitude Wardrobe, Noble
    166850, --Blueprint: Solitude Wine Rack, Noble Full
    166928, --Design: Solitude Bowl, Winter Onions
    166934, --Design: Solitude Platter, Ribs
    166935, --Design: Solitude Serving Pot, Hearty Stew
    166937, --Design: Solitude Serving Pot, Vegetable Soup
    166955, --Design: Solitude Smoking Rack, Sausage
    166929, --Design: Solitude Tray, Fresh Eel
    166776, --Diagram: Solitude Chandelier, Steel
    166779, --Diagram: Solitude Lantern, Hanging
    166778, --Diagram: Solitude Sconce, Lantern
    166777, --Diagram: Solitude Sconce, Wolf's-Head Lantern
    166910, --Diagram: Solitude Serving Dish, Metal
    166861, --Diagram: Solitude Strongbox, Iron Bands
    166853, --Diagram: Solitude Wall Mirror, Ornate
    166887, --Pattern: Solitude Bed, Noble Double
    166890, --Pattern: Solitude Bed, Noble Single
    166791, --Pattern: Solitude Carpet, Plush
    166789, --Pattern: Solitude Carpet, Grand Wolf's-Head Border
    166792, --Pattern: Solitude Carpet, Wolf's-Head Border
    166790, --Pattern: Solitude Runner, Grand Wolf's-Head Border
    166957, --Praxis: Solitude Streetlight, Paired
    166956, --Praxis: Solitude Streetlight, Single
    166857, --Sketch: Solitude Censer, Pagoda
    166856, --Sketch: Solitude Censer, Wolf-Head
    166949, --Sketch: Solitude Goblet, Covered
  },
  [153622] =  --Summerset Journeyman Furnisher's
  {
    139550, --Blueprint: Alinor Armchair, Polished
    139551, --Blueprint: Alinor Armchair, Backless Polished
    139539, --Blueprint: Alinor Bed, Polished Single
    139541, --Blueprint: Alinor Bed, Noble Single
    139531, --Blueprint: Alinor Candles, Tall Stand
    139558, --Blueprint: Alinor Counter, Polished Drawers
    139552, --Blueprint: Alinor Desk, Polished
    139570, --Blueprint: Alinor Jewelry Box, Octagonal
    139555, --Blueprint: Alinor Nightstand, Octagonal
    139485, --Blueprint: Alinor Pew, Polished
    139564, --Blueprint: Alinor Trunk, Engraved
    139563, --Blueprint: Alinor Trunk, Peaked
    139598, --Design: Alinor Amphora, Embossed
    139648, --Design: Alinor Amphora, Portrait
    139594, --Design: Alinor Urn, Gilded
    139533, --Diagram: Alinor Brazier, Hanging Coals
    139526, --Diagram: Alinor Brazier, Standing Coals
    139618, --Diagram: Alinor Platter, Scalloped
    139599, --Diagram: Alinor Urn, Bronze
    139635, --Pattern: Alinor Curtains, Drawn
    139640, --Pattern: Alinor Rug, Alinor Seal
    139644, --Pattern: Alinor Tapestry, Alinor Dusk
    139645, --Pattern: Alinor Tapestry, Royal Gryphons
    139518, --Praxis: Alinor Archway, Tall
    139498, --Praxis: Alinor Archway, Timeworn
    139546, --Praxis: Alinor Bench, Marble
    139502, --Praxis: Alinor Column, Slender Timeworn
    139504, --Praxis: Alinor Column, Timeworn
    139607, --Praxis: Alinor Display Stand, Marble
    139503, --Praxis: Alinor Floor, Ballroom Timeworn
    139507, --Praxis: Alinor Plinth, Sarcophagus
    139515, --Praxis: Alinor Post, Tall Fence
    139630, --Praxis: Alinor Potted Plant, Double Tiered
    139629, --Praxis: Alinor Potted Plant, Triple Tiered
    139631, --Praxis: Alinor Potted Plant, Twin Saplings
    139508, --Praxis: Alinor Sarcophagus, Open
    139604, --Praxis: Alinor Shrine, Limestone Raised
    139510, --Praxis: Alinor Stairway, Timeworn Wide
    139591, --Praxis: Alinor Table, Decorative Marble
    139590, --Praxis: Alinor Table, Round Marble
    139602, --Praxis: Alinor Urn, Limestone Large
    139608, --Praxis: Alinor Wall Shrine, Marble
    139615, --Sketch: Alinor Chalice, Ornate
    139616, --Sketch: Alinor Goblet, Silver Ornate
    139576, --Sketch: Scrimshaw, Sea Monster
    139577, --Sketch: Scrimshaw, Ship
  },
  [153621] =  --Summerset Master Furnisher's
  {
    139545, --Blueprint: Alinor Armchair, Backless Verdant
    139547, --Blueprint: Alinor Armchair, Noble
    139548, --Blueprint: Alinor Armchair, Overhang
    139537, --Blueprint: Alinor Bed, Canopy Full
    139536, --Blueprint: Alinor Bed, Noble Full
    139538, --Blueprint: Alinor Bed, Overhang Full
    139540, --Blueprint: Alinor Bed, Polished Full
    139544, --Blueprint: Alinor Bench, Verdant
    139542, --Blueprint: Alinor Bookcase, Polished
    139649, --Blueprint: Alinor Cabinet, Noble
    139553, --Blueprint: Alinor Desk, Mirrored
    139583, --Blueprint: Alinor Divider, Noble
    139567, --Blueprint: Alinor Jewelry Box, Noble
    139569, --Blueprint: Alinor Jewelry Box, Peaked
    139556, --Blueprint: Alinor Nightstand, Noble
    139592, --Blueprint: Alinor Table, Noble Grand
    139565, --Blueprint: Alinor Trunk, Noble
    139566, --Blueprint: Alinor Trunk, Spired
    139543, --Blueprint: Alinor Wardrobe, Polished
    139484, --Blueprint: Alinor Writing Desk, Noble
    139627, --Blueprint: Display Case, Large
    139626, --Blueprint: Display Case, Specimen
    139624, --Blueprint: Display Case, Standing
    139625, --Blueprint: Display Case, Standing Arched
    139596, --Design: Alinor Amphora, Slender
    139527, --Diagram: Alinor Brazier, Noble
    139528, --Diagram: Alinor Candelabra, Wrought Iron
    139522, --Diagram: Alinor Lantern, Stationary
    139524, --Diagram: Alinor Sconce, Arched Glass
    139525, --Diagram: Alinor Sconce, Lantern
    139523, --Diagram: Alinor Sconce, Wrought Glass
    139535, --Diagram: Alinor Streetlight, Wrought Iron
    139534, --Diagram: Alinor Streetlight, Paired Wrought Iron
    139637, --Pattern: Alinor Carpet, Alinor Crescent
    139638, --Pattern: Alinor Carpet, Verdant
    139636, --Pattern: Alinor Drapes, Noble
    139641, --Pattern: Alinor Runner, Royal
    139501, --Praxis: Alinor Bookcase Wall, Timeworn
    139587, --Praxis: Alinor Fireplace, Ornate
    139588, --Praxis: Alinor Fountain, Four-Way Timeworn
    139628, --Praxis: Alinor Potted Plant, Perpetual Bloom
    139506, --Praxis: Alinor Sarcophagus, Peaked
    139505, --Praxis: Alinor Sarcophagus, Wedge
    139646, --Praxis: Alinor Statue, Kinlord
    139647, --Praxis: Alinor Statue, Orator
    139633, --Praxis: Alinor Windowbox, Blue Wisteria
    139632, --Praxis: Alinor Windowbox, Purple Wisteria
    139573, --Sketch: Figurine, The Fish and the Unicorn
    139571, --Sketch: Figurine, The Sea-Monster's Surprise
    139572, --Sketch: Figurine, The Taming of the Gryphon
    139579, --Sketch: Scrimshaw, Ancient Vessel
    139580, --Sketch: Scrimshaw Jewelry Box, Floral
    139575, --Sketch: Scrimshaw Jewelry Box, Verdant Oval
    139574, --Sketch: Scrimshaw Jewelry Box, Vineyard
    139578, --Sketch: Scrimshaw, Octopus
  }
}