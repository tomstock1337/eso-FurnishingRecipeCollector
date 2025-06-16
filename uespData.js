import axios from 'axios';
import * as cheerio from 'cheerio';
import fs from 'fs';
import { readdir } from 'node:fs/promises';
import ObjectsToCsv from 'objects-to-csv';

const uespBaseUrl = "https://en.uesp.net";
const webDataDir = "uesp/";
const projDir = "FurnishingRecipeCollector/";
const merchRolisURL="https://en.uesp.net/wiki/Online:Rolis_Hlaalu";
const merchRolisFile=webDataDir+"Merchant-Rolis Hlaalu.html";
const merchFaustinaURL="https://en.uesp.net/wiki/Online:Faustina_Curio";
const merchFaustinaFile=webDataDir+"Merchant-Faustina Curio.html";
const projFolioFile=projDir+"dataFolios.lua";
const projGrabBagFile=projDir+"dataGrabBags.lua";
const recipeMarkers=["Blueprint","Blueprints","Sketch","Sketches","Pattern","Patterns","Design","Designs","Praxis","Praxes","Recipe","Formula","Formulae"];
const grabBagMarkers=["Master Furnisher's Document","Journeyman Furnisher's Document","Mixed Furnisher's Document"];
const folioMarkers=["Furnishing Folio"];
const rejectMarkers=["(page)*","(page)","(view contents)","*","[edit]","(image)"];

var itemsRecipes = [];
var itemsFolios = [];
var itemsGrabBags = [];
var folioItems= [];
var folioItemsText="";
var grabBagItems = [];
var grabBagItemsText="";

var previousContainer = "";

function cleanText(text) {

  rejectMarkers.forEach(marker => {
    const escapedMarker = marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    if (text.includes(marker)) {
        text = text.replace(new RegExp(escapedMarker, 'g'), '').trim();
    }
  });

  return text;
}

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

async function scrapeMerchant(url, filename) {
  // Check if the file already exists and is recent enough
  if (checkForCachedData(filename)) {
    return;
  }
  try {
      const response = await axios.get(url);
      const $ = cheerio.load(response.data);
      const items = [];

      const header = $('h1#firstHeading').text().replace('Online:', '').trim();
      const table = $('h2:contains("Wares")').next('table');

      // Get the HTML of the table
      const tableHtml = $.html(table);

      // Write to a local file
      fs.writeFileSync(filename, tableHtml);

      console.log('Wares table HTML exported to '+filename);

  } catch (error) {
      console.error('Error fetching merchant data:', error);
  }
};

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
          itemsGrabBags.push(item);
      } else if (folioMarkers.some(marker => item.Name.includes(marker))) {
          item.Url = uespBaseUrl+currPage(element).find('td:nth-child(2) a:nth-child(2)').attr('href');
          itemsFolios.push(item);
      } else {
          //Don't push items we don't care about
          item.Type = "Item";
          item.Url = currPage(element).find('td:nth-child(2) a:nth-child(1)').attr('href');
      }
      item.Name = cleanText(item.Name);
    });
};

//Uncomment to get fresh data
await scrapeMerchant(merchRolisURL,merchRolisFile);
await scrapeMerchant(merchFaustinaURL,merchFaustinaFile);

await readMerchantData(merchRolisFile);
await readMerchantData(merchFaustinaFile);

// console.log(itemsRecipes);
// console.log(itemsGrabBags);
// console.log(itemsFolios);

//=======================================================================
//  Grab Bag and Folio Page Scraping
//=======================================================================

itemsGrabBags.forEach(async(item) => {
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

itemsFolios.forEach(async(item) => {
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

      console.log('Wares table HTML exported to '+webDataDir+item.Name+".html");

  } catch (error) {
      console.error('Error fetching merchant data:', error);
  }
});

//=======================================================================
//  Analyze Data
//=======================================================================
try {
  const files = await readdir(webDataDir, { withFileTypes: true });

  for (const file of files) {
    if (file.isFile() && file.name.endsWith('.html')) {
      if (grabBagMarkers.some(marker => file.name.includes(marker))) {
        const $ = cheerio.load(fs.readFileSync(file.path+file.name, 'utf8'));
        $('ul li').each((index, element) => {
          const item = {};
          item.Name = cleanText($(element).text());
          item.Url = $(element).find('a').attr('href');
          item.ItemId = $(element).find('a').attr('itemid');
          item.ContainerId=$('h2:nth-child(2)').text().trim();
          item.Container=$('h2:nth-child(1)').text().trim();
          grabBagItems.push(item);
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
          folioItems.push(item);
        });
      }
    }
  };
} catch (error) {
    console.error('Error analyzing data:', error);
}

//=======================================================================
//  Sort the data and generate lua that can be put into the respective files
//=======================================================================
function sortByContainerAndItemId(a, b) {
  // First, compare by Container
  if (a.Container < b.Container) return -1;
  if (a.Container > b.Container) return 1;
  // If Container is the same, compare by ItemId
  if (a.Name < b.Name) return -1;
  if (a.Name > b.Name) return 1;
  return 0; // They are equal
}
folioItems.sort(sortByContainerAndItemId);
grabBagItems.sort(sortByContainerAndItemId);

function processItems(items, itemsTextVar) {
  let previousContainer = "";
  items.forEach((item, index) => {
    if (item.Container !== previousContainer) {
      if (previousContainer !== "") {
        itemsTextVar.value += "\t\t},\n";
      }
      itemsTextVar.value += '[' + item.ContainerId + ']= --' + item.Container + '\n\t{\n';
    } else {
      itemsTextVar.value += "\t\t\t" + item.ItemId + ", --" + item.Name + "\n";
    }
    if (index === items.length - 1) {
      itemsTextVar.value += "\t\t},\n";
    }
    previousContainer = item.Container;
  });
}

let folioItemsTextObj = { value: "" };
let grabBagItemsTextObj = { value: "" };

processItems(folioItems, folioItemsTextObj);
processItems(grabBagItems, grabBagItemsTextObj);

// Access the results
folioItemsText = folioItemsTextObj.value;
grabBagItemsText = grabBagItemsTextObj.value;

folioItemsText = folioItemsText.replace(/\t/g, '  ');
grabBagItemsText = grabBagItemsText.replace(/\t/g, '  ');

fs.writeFileSync('folios_new.lua', folioItemsText);
fs.writeFileSync('grabbags_new.lua', grabBagItemsText);

//Grab the data from the project lua files

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

await readProjLuaFile(projFolioFile,'folios_old.lua');
await readProjLuaFile(projGrabBagFile,'grabbags_old.lua');

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
console.log(JSON.stringify(
  compareLuaFiles('folios_new.lua', 'folios_old.lua'),
  null, 2 // 2-space indentation
));
console.log(JSON.stringify(
  compareLuaFiles('grabbags_new.lua', 'grabbags_old.lua'),
  null, 2 // 2-space indentation
));