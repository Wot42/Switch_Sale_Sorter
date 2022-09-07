
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateGamesModel() {

    const { getGamesEurope} = require("nintendo-switch-eshop");
    const fs = require('fs');

    (async () => {
      console.log("Fetching all games...");
      const games = await getGamesEurope();
      const discountPrices = games.filter(p => p.price_has_discount_b == true);
      console.log(`Found ${discountPrices.length} games on sale`);


      discountPrices.forEach(((game) => {
        //push to games.


      }) )
    })();

  }

  updateGamesModelTest() {

    const hash ={
      game: {
        title: "Ooblets",
        pic: "https://fs-prod-cdn.nintendo-europe.com/media/images/10_share_images/games_15/nintendo_switch_download_software_1/2x1_NSwitchDS_Ooblets_image500w.jpg",
        price: 26.99,
        sale_price: 19.08,
        api_id: "/Games/Nintendo-Switch-download-software/Ooblets-2209603.html"
      }
    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");



    fetch("http://localhost:3000/games", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,

      },

      body: JSON.stringify(hash)
    })

    .then((response) => responce.body)
    .then((data)=> console.log(data))


  }


}
