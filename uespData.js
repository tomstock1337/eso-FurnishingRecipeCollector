import axios from 'axios';
import * as cheerio from 'cheerio';
import fs from 'fs';
import path from 'path';

const overwriteProjectFiles = false;
const cleanupFiles = false;

// Constants
const uespBaseUrl = "https://en.uesp.net";
const uespItemLookupUrl = "https://esoitem.uesp.net/itemLink.php?&itemid="
const webDataDir = "uesp/";
const projDir = "FurnishingRecipeCollector/";
const merchRolisURL="https://en.uesp.net/wiki/Online:Rolis_Hlaalu";
const merchRolisFile=webDataDir+"_Merchant-Rolis Hlaalu.html";
const merchFaustinaURL="https://en.uesp.net/wiki/Online:Faustina_Curio";
const merchFaustinaFile=webDataDir+"_Merchant-Faustina Curio.html";
const projFolioFile=projDir+"dataFolios.lua";
const projGrabBagFile=projDir+"dataGrabBags.lua";
const projLooseRecipesFile=projDir+"dataMisc.lua";
const recipeMarkers=["Blueprint","Blueprints","Sketch","Sketches","Pattern","Patterns","Design","Designs","Praxis","Praxes","Formula","Formulae",'Diagram','Diagrams'];
const grabBagMarkers=["Master Furnisher's Document","Journeyman Furnisher's Document","Mixed Furnisher's Document"];
const folioMarkers=["Furnishing Folio"];
const rejectMarkers=["(page)*","(page)","(view contents)","*","[edit]","(image)"];

  // {
  //   Icon: '/wiki/File:ON-icon-plan-Sketch_5.png',
  //   Name: 'Sketch: Colovian Mirror, Standing(Colovian Mirror, Standing)',
  //   ItemId: '211037',
  //   Price: '100',
  //   Url: 'https://en.uesp.net//esoitem.uesp.net/itemLink.php?&itemid=211037&quality=5'
  // }
var containersFolios = [];
var containersGrabBags = [];
//Sample data structure for containers
  // {
  //   Icon: '/wiki/File:ON-icon-book-Closed_02.png',
  //   Name: 'Western Skyrim Furnishing Folio',
  //   ItemId: '171808',
  //   Price: '700',
  //   Url: 'https://en.uesp.net/wiki/Online:Western_Skyrim_Furnishing_Folio'
  // }
var folioItemsRecipes= [];
var grabBagItemsRecipes = [];
var looseRecipes = [];
// Sample data structure for items in containers
  // {
  //   Name: 'Pattern: Solitude Loom, Warp-Weighted',
  //   Url: '//esoitem.uesp.net/itemLink.php?&itemid=167379&quality=5',
  //   ItemId: '167379',
  //   ContainerId: '171808',
  //   Container: 'Western Skyrim Furnishing Folio'
  // },
var folioItemsRecipesLua="";
var grabBagItemsRecipesLua="";
// Sample data structure for lua variables
  // [171808]= --Western Skyrim Furnishing Folio
  // {
  //   167380, --Blueprint: Solitude Game, Blood-on-the-Snow
  //   167383, --Design: Solitude Smoking Rack, Fish
  //   167378, --Diagram: Vampiric Chandelier, Azure Wrought-Iron
  //   167382, --Formula: Winter Cardinal Painting, In Progress
  //   167379, --Pattern: Solitude Loom, Warp-Weighted
  //   167381, --Praxis: Ancient Nord Monolith, Head
  //   167384, --Sketch: Blackreach Geode, Iridescent
  // },
var looseRecipesLua=""

var jsonFolioCompare = {};
var jsonGrabBagCompare = {};
var jsonLooseRecipesCompare = {};
//Sample data structure for comparison results
  // {
  //   "addedContainers": [],
  //   "removedContainers": [],
  //   "changedContainers": {
  //     "121364": {
  //       "name": "Hlaalu Master Furnisher's Document",
  //       "addedItems": [],
  //       "removedItems": [
  //         "115968",
  //         "121373",
  //         "121374"
  //       ]
  //     },
  //   },
  //   "sameContainers": [
  //     "153888",
  //     "159654"
  //   ]
  // }

// Helper Functions=================================================
// Sleep function to pause execution for given milliseconds
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
// Function to clean text by removing unwanted markers as defined in rejectMarkers
function cleanText(text) {
  rejectMarkers.forEach(marker => {
    const escapedMarker = marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    if (text.includes(marker)) {
        text = text.replace(new RegExp(escapedMarker, 'g'), '').trim();
    }
  });
  return text;
}
function removeRecipeMarkers(text) {
  recipeMarkers.forEach(marker => {
    const escapedMarker = marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    if (text.includes(marker)) {
        text = text.replace(new RegExp(escapedMarker, 'g'), '').trim();
    }
  });
  return text;
}
function detectRecipeMarker(text) {
  for (const marker of recipeMarkers) {
    const escapedMarker = marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const regex = new RegExp(escapedMarker, 'g');
    if (regex.test(text)) {
      return marker;
    }
  }
  return null;
}
function sortByContainerAndItemName(a, b) {
  // First, compare by Container
  if (a.Container < b.Container) return -1;
  if (a.Container > b.Container) return 1;
  // If Container is the same, compare by ItemId
  if (a.Name < b.Name) return -1;
  if (a.Name > b.Name) return 1;
  return 0; // They are equal
}
function sortByRecipeVendorTtypeName(a, b) {
  // First, compare by Container
  if (a.Vendor < b.Vendor) return -1;
  if (a.Vendor > b.Vendor) return 1;
  // If Container is the same, compare by ItemId
  if (a.Type < b.Type) return -1;
  if (a.Type > b.Type) return 1;
  // If Container is the same, compare by ItemId
  if (a.Name < b.Name) return -1;
  if (a.Name > b.Name) return 1;
  return 0; // They are equal
}
// Function to check if a file exists and if it was modified within the last 7 days
function checkForCachedData(filename) {
  if (fs.existsSync(filename)) {
    const stats = fs.statSync(filename); // Get file stats synchronously
    const lastModified = stats.mtime;    // Last modified time as a Date object
    const now = new Date();
    const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000); // 7 days in ms

    if (lastModified >= sevenDaysAgo) {
      return true;
    }
  }
  return false;
}
// This function will generate code that can be hot swapped in the main project lua files
function CreateLuaDataStructureForContainers(items) {
  let output = "";
  let previousContainer = "";
  items.forEach((item, index) => {
    if (item.Container !== previousContainer) {
      if (previousContainer !== "") {
        output += "\t},\n";
      }
      output += '\t[' + item.ContainerId + ']= --' + item.Container + '\n\t{\n';
      output += "\t\t" + item.ItemId + ", --" + item.Name + "\n";
    } else {
      output += "\t\t" + item.ItemId + ", --" + item.Name + "\n";
    }
    if (index === items.length - 1) {
      output += "\t},\n";
    }
    previousContainer = item.Container;
  });
  return output.replace(/\t/g, '  ');
}
function CreateLuaDataStructureForRecipeList(items) {
  let output = "";
  items.forEach((item, index) => {
    output += "\t[" + item.ItemId + "]={location=\""+item.Vendor+"\"}, --" + item.Name + "\n";
  });
  return output.replace(/\t/g, '  ');
}
function readProjLuaFile(filePath, projFilePath){
  const luaFile = fs.readFileSync(filePath, 'utf8');
  const pattern = /--AUTOMATION START=+\s*([\s\S]*?)--AUTOMATION END=+/m;
  const match = luaFile.match(pattern);
  if (match && match[1]) {
    const extractedData = match[1].trim();
    fs.writeFileSync(projFilePath, extractedData);
  } else {
    console.log('Markers not found or no data between them.');
  }
};
function writeProjLuaFile(projFilePath, contents){
  const luaFile = fs.readFileSync(projFilePath, 'utf8');
  const pattern = /(\-\-AUTOMATION START=+)([\s\S]*?)(\-\-AUTOMATION END=+)/m;
  const match = luaFile.match(pattern);
  if (match) {
    // Reconstruct the file with new contents between the markers
    const newLuaFile = luaFile.replace(pattern, `$1\n${contents}\n$3`);
    fs.writeFileSync(projFilePath, newLuaFile);
  } else {
    console.log('Markers not found or no data between them.');
  }
};
// Lua file comparison function==========================
// These functions were written by Perplexity for assistance with project.
function compareLuaFilesOfContainers(file1Path, file2Path) {
    // Read and parse both files
    const file1 = parseLuaFileOfContainers(fs.readFileSync(file1Path, 'utf8'));
    const file2 = parseLuaFileOfContainers(fs.readFileSync(file2Path, 'utf8'));

    // Compare containers
    const result = {
        addedContainers: [],
        removedContainers: [],
        changedContainers: {},
        sameContainers: []
    };

    // Check containers present in both files
    const allContainerIds = new Set([
        ...Object.keys(file1),
        ...Object.keys(file2)
    ]);

    allContainerIds.forEach(containerId => {
        const container1 = file1[containerId];
        const container2 = file2[containerId];

        if (!container1) {
            result.addedContainers.push(containerId);
            return;
        }
        if (!container2) {
            result.removedContainers.push(containerId);
            return;
        }

        // Compare items within container (order-agnostic)
        const items1 = new Set(container1.items);
        const items2 = new Set(container2.items);

        const addedItems = [...items2].filter(x => !items1.has(x));
        const removedItems = [...items1].filter(x => !items2.has(x));

        if (addedItems.length > 0 || removedItems.length > 0) {
            result.changedContainers[containerId] = {
                name: container1.name,
                addedItems,
                removedItems
            };
        } else {
            result.sameContainers.push(containerId);
        }
    });

    return result;
}
function compareLuaFilesOfRecipes(file1Path, file2Path) {
    // Read and parse both files
    const data1 = parseLuaFileOfRecipes(fs.readFileSync(file1Path, 'utf8'));
    const data2 = parseLuaFileOfRecipes(fs.readFileSync(file2Path, 'utf8'));

    // Compare individual entries
    const result = {
        addedEntries: [],
        removedEntries: [],
        sameEntries: []
    };

    const allIds = new Set([
        ...Object.keys(data1),
        ...Object.keys(data2)
    ]);

    allIds.forEach(id => {
        const entry1 = data1[id];
        const entry2 = data2[id];

        if (!entry1) {
            result.addedEntries.push(id);
        } else if (!entry2) {
            result.removedEntries.push(id);
        } else {
            // Compare location values
            if (entry1.location === entry2.location) {
                result.sameEntries.push(id);
            } else {
                result.changedEntries[id] = {
                    oldLocation: entry1.location,
                    newLocation: entry2.location
                };
            }
        }
    });

    return result;
}
function parseLuaFileOfContainers(content) {
    const containers = {};
    // Split into container blocks using regex
    const containerBlocks = content.split(/(?=\[\d+\]\s*\=\s*--)/g);

    containerBlocks.forEach(block => {
        const containerMatch = block.match(/\[(\d+)\]\s*\=\s*--(.+)\s*/);
        if (!containerMatch) return;

        const containerId = containerMatch[1];
        const containerName = containerMatch[2].trim();
        const items = [];

        // Extract numeric item IDs
        const itemLines = block.split('\n').slice(2); // Skip header lines
        itemLines.forEach(line => {
            const itemMatch = line.match(/(\d+),/);
            if (itemMatch) {
                items.push(itemMatch[1]);
            }
        });

        containers[containerId] = {
            name: containerName,
            items: items.sort() // Sort for consistent comparison
        };
    });

    return containers;
}
function parseLuaFileOfRecipes(content) {
    const entries = {};

    // Split content into lines and process each line individually
    // Normalize all line endings to '\n' before splitting
    const lines = content.replace(/\r\n?/g, '\n').split('\n');

    lines.forEach(line => {
        // Regex to capture: [id], location, and item name
        const match = line.match(/^\s*\[(\d+)\]=\{location="([^"]+)"\},\s*--\s*(.+)$/);

        if (match) {
            const id = match[1];
            const location = match[2];
            const itemName = match[3].trim();

            entries[id] = {
                location: location,
                itemName: itemName
            };
        }
    });
    return entries;
}


// Web Scraping Functions========================================
async function scrapeMerchantPage(url, filename) {
  // Check if the file already exists and is recent enough
  if (checkForCachedData(filename)) {
    return;
  }
  try {
      const response = await axios.get(url);
      const $ = cheerio.load(response.data);
      const table = $('h2:contains("Wares")').next('table');

      // Get the HTML of the table
      const tableHtml = $.html(table);

      // Write to a local file
      fs.writeFileSync(filename, tableHtml);

      console.log('Merchant inventory exported from '+filename);

  } catch (error) {
      console.error('Error fetching merchant data:', error);
  }
};
async function scrapeContainerPages() {
  containersGrabBags.forEach(async(item) => {
    var filename = webDataDir+item.Name+".html"
    // Check if the file already exists and is recent enough
    if (checkForCachedData(filename)) {
      return;
    } else {
      console.log('Visiting Grab Bag: '+item.Name + " - " + item.Url);
    }
    try {
        const response = await axios.get(item.Url);
        const $ = cheerio.load(response.data);
        var allHTML="";
        allHTML+="<h2>"+item.Name+"</h2>";
        allHTML+="<h2>"+item.ItemId+"</h2>";

        recipeMarkers.forEach(marker => {
          const list = $('h2').filter(function(){
            if ( cleanText($(this).text()) === marker) {
              return true;
            }}).next('ul');

            // Get the HTML of the table
            allHTML += $.html(list);
          });

        // Write to a local file
        fs.writeFileSync(filename, allHTML);
    } catch (error) {
        console.error('Error fetching merchant data:', error);
    }
    return true;
  });

  containersFolios.forEach(async(item) => {
    var filename = webDataDir+item.Name+".html"
    // Check if the file already exists and is recent enough
    if (checkForCachedData(filename)) {
      return;
    }
    else {
      console.log('Visiting Folio: '+item.Name + " - " + item.Url);
    }
    try {
        const response = await axios.get(item.Url);
        const $ = cheerio.load(response.data);
        var allHTML="";
        allHTML+="<h2>"+item.Name+"</h2>";
        allHTML+="<h2>"+item.ItemId+"</h2>";

        const table = $('h2:contains("Contents")').next('ul');

        // Get the HTML of the table
        allHTML+=$.html(table);

        // Write to a local file
        fs.writeFileSync(webDataDir+item.Name+".html", allHTML);

    } catch (error) {
        console.error('Error fetching merchant data:', error);
    }
  });
};
async function scrapeItemPage(itemId, filename) {
  if (checkForCachedData(filename)) {
    return;
  }
  try {
    const response = await axios.get(uespItemLookupUrl + itemId);
    const $ = cheerio.load(response.data);
    const table = $('table#esoil_rawdatatable');

    // Get the HTML of the table
    const tableHtml = $.html(table);

    // Write to a local file
    await fs.writeFileSync(filename, tableHtml);

  } catch (error) {
    console.error(`Error fetching item data for ID ${itemId}:`, error);
    return null;
  }
}

// File Reading Functions========================================
async function readMerchantData(filename) {
  const currPage = cheerio.load(fs.readFileSync(filename, 'utf8'));
  currPage('tr').each((index, element) => {
      const item = {};
      item.Icon = currPage(element).find('td:nth-child(1) a').attr('href');
      item.Name = currPage(element).find('td:nth-child(2) a:first').text().trim();
      item.ItemId = currPage(element).find('td:nth-child(2) a:first').attr('itemid');
      item.Price = currPage(element).find('td:nth-child(3) span>span').text().trim();
      if (recipeMarkers.some(marker => item.Name.includes(marker))) {
          item.Url = uespBaseUrl+currPage(element).find('td:nth-child(2) a:nth-child(1)').attr('href');
          item.Type = detectRecipeMarker(item.Name);
          if (filename.includes("Rolis")){
            item.Vendor = "Rolis Hlaalu Writ Vendor";
          } else if (filename.includes("Faustina")) {
            item.Vendor = "Faustina Curio Writ Vendor";
          }
          looseRecipes.push(item);
      } else if (grabBagMarkers.some(marker => item.Name.includes(marker))) {
          item.Url = uespBaseUrl+currPage(element).find('td:nth-child(2) a:nth-child(2)').attr('href');
          containersGrabBags.push(item);
      } else if (folioMarkers.some(marker => item.Name.includes(marker))) {
          item.Url = uespBaseUrl+currPage(element).find('td:nth-child(2) a:nth-child(2)').attr('href');
          containersFolios.push(item);
      } else {
          //Don't push items we don't care about
          item.Type = "Item";
          item.Url = currPage(element).find('td:nth-child(2) a:nth-child(1)').attr('href');
      }
      item.Name = cleanText(item.Name);
    });
};
async function readContainerData() {
  try {
    const files = await fs.promises.readdir(webDataDir, { withFileTypes: true });

    for (const file of files) {
      if (file.isFile() && file.name.endsWith('.html')) {
        if (grabBagMarkers.some(marker => file.name.includes(marker))) {
          const $ = cheerio.load(fs.readFileSync(path.join(webDataDir, file.name), 'utf8'));
          $('ul li').each((index, element) => {
            const item = {};
            item.Name = cleanText($(element).text());
            item.Url = $(element).find('a').attr('href');
            item.ItemId = $(element).find('a').attr('itemid');
            item.ContainerId=$('h2:nth-child(2)').text().trim();
            item.Container=$('h2:nth-child(1)').text().trim();
            item.Type = detectRecipeMarker(item.Name);
            grabBagItemsRecipes.push(item);
          });
        }
        if (folioMarkers.some(marker => file.name.includes(marker))) {
          const $ = cheerio.load(fs.readFileSync(file.path+file.name, 'utf8'));
          $('ul li').each((index, element) => {
            const item = {};
            item.Name = cleanText($(element).text());
            item.Url = $(element).find('a').attr('href');
            item.ItemId = $(element).find('a').attr('itemid');
            item.ContainerId=$('h2:nth-child(2)').text().trim();
            item.Container=$('h2:nth-child(1)').text().trim();
            item.Type = detectRecipeMarker(item.Name);
            folioItemsRecipes.push(item);
          });
        }
      }
    };
  } catch (error) {
      console.error('Error analyzing data:', error);
  }
};
async function readItemPage(filename) {
  try {
    const currPage = cheerio.load(fs.readFileSync(filename, 'utf8'));
    const item = {};
    item.Raw = currPage('table tr').filter(function() {
                    return currPage(this).find('td:first').text().trim() === "name";
                  }).find('td').eq(1).text();
    item.Type = detectRecipeMarker(item.Raw);
    item.Name = removeRecipeMarkers(item.Raw).replace(":",""); // Get the second <td> (index 1)

    return item;
  } catch (error) {
      console.error('Error analyzing data:', error);
  }
};
async function processContainers(containers) {
  const containerIds = Object.keys(containers);

  for (const containerId of containerIds) {
    // Output container information
    containersGrabBags
      .filter(item => item.ItemId === containerId)
      .forEach(item => {
        console.log(`Container ID: ${containerId} (${containers[containerId].name}) - ${item.Url}`);
      });
    containersFolios
      .filter(item => item.ItemId === containerId)
      .forEach(item => {
        console.log(`Container ID: ${containerId} (${containers[containerId].name}) - ${item.Url}`);
      });

    const printedTypes = new Set(); // Track types printed for this container
    if (containers[containerId].removedItems.length > 0){
      console.log(`########## Items in addon that need to be added to UESP`);
    }
    for (const itemId of containers[containerId].removedItems) {
      var itemData = grabBagItemsRecipes.find(i => i.ItemId === itemId) || folioItemsRecipes.find(i => i.ItemId === itemId);

      if (!itemData) {
        try {
          const filename = webDataDir + itemId + ".html";
          await scrapeItemPage(itemId, filename);
          itemData = await readItemPage(filename);

        } catch (error) {
          console.error(`Failed to process item ${itemId}:`, error);
        }
      }
      if (!printedTypes.has(itemData.Type)) {
        console.log(itemData.Type);
        printedTypes.add(itemData.Type);
      }
      console.log(`* {{Furnishing Recipe Link Short|${itemData.Name}}}`);
    }
    if (containers[containerId].addedItems.length > 0){
      console.log(`########## Items in UESP that need to be added to addon`);
    }
    for (const itemId of containers[containerId].addedItems) {
      const itemData = grabBagItemsRecipes.find(i => i.ItemId === itemId) || folioItemsRecipes.find(i => i.ItemId === itemId);

      if (itemData) {
        console.log(`  - ${itemData.Name} (${itemData.ItemId})`);
      } else {
        try {
          const filename = webDataDir + itemId + ".html";
          await scrapeItemPage(itemId, filename);
          const item = await readItemPage(filename);

          if (!printedTypes.has(item.Type)) {
            console.log(item.Type);
            printedTypes.add(item.Type);
          }
          console.log(`* {{Furnishing Recipe Link Short|${item.Name}}}`);
        } catch (error) {
          console.error(`Failed to process item ${itemId}:`, error);
        }
      }
    }
  }
}
async function processRecipeList(list) {
  console.log(`########## Items in addon that need to be added to UESP`);
  if (list.removedEntries.length > 0){
    console.log(`########## Items in addon that need to be added to UESP`);
  }
  for (const itemId of list.removedEntries) {
    var itemData = looseRecipes.find(i => i.ItemId === itemId);

    if (!itemData) {
      try {
        const filename = webDataDir + itemId + ".html";
        await scrapeItemPage(itemId, filename);
        itemData = await readItemPage(filename);
      } catch (error) {
        console.error(`Failed to process item ${itemId}:`, error);
      }
    }
    console.log(`* {{Furnishing Recipe Link Short|${itemData.Name}}}`);
  }
  if (list.removedEntries.length > 0){
    console.log(`########## Items in UESP that need to be added to addon`);
  }
  for (const itemId of list.addedEntries) {
    var itemData = looseRecipes.find(i => i.ItemId === itemId);

    if (!itemData) {
      try {
        const filename = webDataDir + itemId + ".html";
        await scrapeItemPage(itemId, filename);
        itemData = await readItemPage(filename);
      } catch (error) {
        console.error(`Failed to process item ${itemId}:`, error);
      }
    }
    console.log(`  [${itemData.ItemId}]={location="${itemData.Vendor}"}, --${itemData.Name}`);
  }
}

//=======================================================================
//Main Logic of the Script===============================================
//=======================================================================

//Uncomment to get fresh data
await scrapeMerchantPage(merchRolisURL,merchRolisFile);
await scrapeMerchantPage(merchFaustinaURL,merchFaustinaFile);

await readMerchantData(merchRolisFile);
await readMerchantData(merchFaustinaFile);

await scrapeContainerPages();

await sleep(2000); //buffer to wait until files are created.

await readContainerData();

//populated from readContainerData()
folioItemsRecipes.sort(sortByContainerAndItemName);
grabBagItemsRecipes.sort(sortByContainerAndItemName);
looseRecipes.sort(sortByRecipeVendorTtypeName);

folioItemsRecipesLua = CreateLuaDataStructureForContainers(folioItemsRecipes);
grabBagItemsRecipesLua = CreateLuaDataStructureForContainers(grabBagItemsRecipes);
looseRecipesLua = CreateLuaDataStructureForRecipeList(looseRecipes);

fs.writeFileSync('folios_new.lua', folioItemsRecipesLua);
fs.writeFileSync('grabbags_new.lua', grabBagItemsRecipesLua);
fs.writeFileSync('looserecipes_new.lua', looseRecipesLua);

await readProjLuaFile(projFolioFile,'folios_old.lua');
await readProjLuaFile(projGrabBagFile,'grabbags_old.lua');
await readProjLuaFile(projLooseRecipesFile,'looserecipes_old.lua');

jsonFolioCompare = await compareLuaFilesOfContainers('folios_old.lua', 'folios_new.lua');
jsonGrabBagCompare = await compareLuaFilesOfContainers('grabbags_old.lua', 'grabbags_new.lua');
jsonLooseRecipesCompare = await compareLuaFilesOfRecipes('looserecipes_old.lua', 'looserecipes_new.lua');

console.log("Grab Bag Comparison Results==================================");
await processContainers(jsonGrabBagCompare.changedContainers)

console.log("Folio Comparison Results==================================");
await processContainers(jsonFolioCompare.changedContainers)

console.log("Loose Recipe Comparison Results==================================");
await processRecipeList(jsonLooseRecipesCompare);

if (overwriteProjectFiles){
  await writeProjLuaFile(projFolioFile,folioItemsRecipesLua);
  await writeProjLuaFile(projGrabBagFile,grabBagItemsRecipesLua);
  await writeProjLuaFile(projLooseRecipesFile,looseRecipesLua);
  console.log("Project files updated with new data.");
}
if (cleanupFiles) {
  const webfiles = await fs.promises.readdir(webDataDir);
  const comparefiles = ['folios_old.lua','grabbags_old.lua','folios_new.lua','grabbags_new.lua'];

  // Delete files and directories in webDataDir
  for (const file of webfiles) {
    const filePath = path.join(webDataDir, file);
    const stat = await fs.promises.lstat(filePath);
    if (stat.isDirectory()) {
      await fs.promises.rm(filePath, { recursive: true, force: true });
    } else {
      await fs.promises.unlink(filePath);
    }
  }
  // Delete comparefiles in current directory
  await Promise.all(comparefiles.map(async (file) => {
    const filePath = path.join(process.cwd(), file); // Ensures current directory
    try {
      await fs.promises.rm(filePath, { force: true });
      console.log(`${file} deleted successfully.`);
    } catch (err) {
      console.error(`Error deleting file ${file}: ${err}`);
    }
  }));
};