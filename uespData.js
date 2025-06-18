import axios from 'axios';
import * as cheerio from 'cheerio';
import fs from 'fs';
import path from 'path';
import { readdir } from 'node:fs/promises';
import ObjectsToCsv from 'objects-to-csv';

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
const recipeMarkers=["Blueprint","Blueprints","Sketch","Sketches","Pattern","Patterns","Design","Designs","Praxis","Praxes","Recipe","Formula","Formulae"];
const grabBagMarkers=["Master Furnisher's Document","Journeyman Furnisher's Document","Mixed Furnisher's Document"];
const folioMarkers=["Furnishing Folio"];
const rejectMarkers=["(page)*","(page)","(view contents)","*","[edit]","(image)"];

var itemsRecipes = [];
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
var folioItemRecipes= [];
var grabBagItemsRecipes = [];
// Sample data structure for items in containers
  // {
  //   Name: 'Pattern: Solitude Loom, Warp-Weighted',
  //   Url: '//esoitem.uesp.net/itemLink.php?&itemid=167379&quality=5',
  //   ItemId: '167379',
  //   ContainerId: '171808',
  //   Container: 'Western Skyrim Furnishing Folio'
  // },
var folioItemRecipesLua="";
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
function sortByContainerAndItemName(a, b) {
  // First, compare by Container
  if (a.Container < b.Container) return -1;
  if (a.Container > b.Container) return 1;
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
function CreateLuaDataStructure(items) {
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
function readProjLuaFile(filePath, projFilePath){
  const luaFile = fs.readFileSync(filePath, 'utf8');
  const match = luaFile.match(/--AUTOMATION START=+\s*([\s\S]*?)--AUTOMATION END=+/m);
  if (match && match[1]) {
    const extractedData = match[1].trim();
    fs.writeFileSync(projFilePath, extractedData);
  } else {
    console.log('Markers not found or no data between them.');
  }
};
// Lua file comparison function==========================
// These functions were written by Perplexity for assistance with project.
function compareLuaFiles(file1Path, file2Path) {
  console.log(file1Path, file2Path);
    // Read and parse both files
    const file1 = parseLuaFile(fs.readFileSync(file1Path, 'utf8'));
    const file2 = parseLuaFile(fs.readFileSync(file2Path, 'utf8'));

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

function parseLuaFile(content) {
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
async function scrapeItemPage(itemId) {
  const filename = webDataDir + itemId + ".html";
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
    fs.writeFileSync(filename, tableHtml);

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
      item.Name = currPage(element).find('td:nth-child(2)').text().trim();
      item.ItemId = currPage(element).find('td:nth-child(2) a').attr('itemid');
      item.Price = currPage(element).find('td:nth-child(3) span>span').text().trim();
      if (recipeMarkers.some(marker => item.Name.includes(marker))) {
          item.Url = uespBaseUrl+currPage(element).find('td:nth-child(2) a:nth-child(1)').attr('href');
          itemsRecipes.push(item);
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
            folioItemRecipes.push(item);
          });
        }
      }
    };
  } catch (error) {
      console.error('Error analyzing data:', error);
  }
};

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

folioItemRecipes.sort(sortByContainerAndItemName);
grabBagItemsRecipes.sort(sortByContainerAndItemName);

folioItemRecipesLua = CreateLuaDataStructure(folioItemRecipes);
grabBagItemsRecipesLua = CreateLuaDataStructure(grabBagItemsRecipes);

fs.writeFileSync('folios_new.lua', folioItemRecipesLua);
fs.writeFileSync('grabbags_new.lua', grabBagItemsRecipesLua);

await readProjLuaFile(projFolioFile,'folios_old.lua');
await readProjLuaFile(projGrabBagFile,'grabbags_old.lua');

var jsonFolioCompare = compareLuaFiles('folios_old.lua', 'folios_new.lua');
var jsonGrabBagCompare = compareLuaFiles('grabbags_old.lua', 'grabbags_new.lua');

// console.log("Folio Comparison Results:");
// console.log("Added Containers:", jsonFolioCompare.addedContainers);
// console.log("Removed Containers:", jsonFolioCompare.removedContainers);
// console.log("Changed Containers:", jsonFolioCompare.changedContainers);
// console.log("Same Containers:", jsonFolioCompare.sameContainers);


console.log("Grab Bag Comparison Results:");
var changedContainers = jsonGrabBagCompare.changedContainers;
Object.keys(changedContainers).forEach(containerId => {

  containersGrabBags.filter(item => item.ItemId === containerId).forEach(item => {
    console.log(`Container ID: ${containerId} (${changedContainers[containerId].name}) - ${item.Url}`);
  });

  changedContainers[containerId].removedItems.forEach(item => {
    const itemData = grabBagItemsRecipes.find(i => i.ItemId === item);
    if (itemData) {
      console.log(`  - ${itemData.Name} (${itemData.ItemId})`);
    } else {
      scrapeItemPage(item);
      console.log(`  - Item ID ${item} not found in grab bag items.`);
    }
  });
});