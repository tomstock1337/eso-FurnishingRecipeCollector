import axios from 'axios';
import * as cheerio from 'cheerio';
import fs from 'fs';
import ObjectsToCsv from 'objects-to-csv';

const uespBaseUrl = "https://en.uesp.net";
const webDataDir = "webdata/";
const merchRolisURL="https://en.uesp.net/wiki/Online:Rolis_Hlaalu";
const merchRolisFile=webDataDir+"Merchant-Rolis Hlaalu.html";
const merchFaustinaURL="https://en.uesp.net/wiki/Online:Faustina_Curio";
const merchFaustinaFile=webDataDir+"Merchant-Faustina Curio.html";
const recipeMarkers=["Blueprint","Blueprints","Sketch","Sketches","Pattern","Patterns","Design","Designs","Praxis","Praxes","Recipe","Formula","Formulae"];
const grabBagMarkers=["Master Furnisher's Document","Journeyman Furnisher's Document","Mixed Furnisher's Document"];
const folioMarkers=["Furnishing Folio"];
const rejectMarkers=["(page)*","(page)","(view contents)","*","[edit]"];

var itemsRecipes = [];
var itemsFolios = [];
var itemsGrabBags = [];

function cleanText(text) {

  rejectMarkers.forEach(marker => {
    const escapedMarker = marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    if (text.includes(marker)) {
        text = text.replace(new RegExp(escapedMarker, 'g'), '').trim();
    }
  });

  return text;
}

async function scrapeMerchant(url, filename) {
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

// itemsRecipes.forEach(item => {
//   console.log(item.Name + " - " + uespBaseUrl+item.Url);
// });

itemsGrabBags.forEach(async(item) => {
  console.log('Visiting Grab Bag: '+item.Name + " - " + item.Url);
  try {
      const response = await axios.get(item.Url);
      const $ = cheerio.load(response.data);
      const items = [];
      var allHTML="";

      recipeMarkers.forEach(marker => {
        const list = $('h2').filter(function(){
          if ( cleanText($(this).text()) === marker) {
            console.log("Found section: "+marker);
            return true;
          }}).next('ul');

          // Get the HTML of the table
          allHTML += $.html(list);
        });

      // Write to a local file
      fs.writeFileSync(webDataDir+item.Name+".html", allHTML);
  } catch (error) {
      console.error('Error fetching merchant data:', error);
  }
  return true;
});

itemsFolios.forEach(async(item) => {
  console.log('Visiting Folio: '+item.Name + " - " + item.Url);
  try {
      const response = await axios.get(item.Url);
      const $ = cheerio.load(response.data);
      const items = [];

      const table = $('h2:contains("Contents")').next('ul');

      // Get the HTML of the table
      const tableHtml = $.html(table);

      // Write to a local file
      fs.writeFileSync(webDataDir+item.Name+".html", tableHtml);

      console.log('Wares table HTML exported to '+webDataDir+item.Name+".html");

  } catch (error) {
      console.error('Error fetching merchant data:', error);
  }
});
