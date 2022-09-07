import { Controller } from "@hotwired/stimulus"
import { getGamesEurope} from 'nintendo-switch-eshop';

// Connects to data-controller="fetch-games"
export default class extends Controller {
  connect() {
    console.log("any string 4");


  }

  postGamesToRuby(sentGame) {
    console.log("also running");

    const hash ={
      game: {
        title: sentGame.title,
        pic: sentGame.image_url_h2x1_s,
        price: sentGame.price_regular_f,
        sale_price: sentGame.price_sorting_f,
        api_id: sentGame.url
      }
    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");


    fetch("http://localhost:3000/games", {
      method: "POST",
      headers: {
        mode: "no-cors",
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken

      },

      body: JSON.stringify(hash)
    })

    .then((response) => response.body)
    .then((data)=> console.log(data))


  }

  updateGamesModel() {
    console.log("running 1");
    // console.log(getGamesEurope);

   (async () => {
      console.log("Fetching all games...");
      const games = await getGamesEurope();
      const discountPrices = games.filter(p => p.price_has_discount_b == true);
      console.log(`Found ${discountPrices.length} games on sale`);


      discountPrices.forEach(((game) => {
        this.postGamesToRuby(game)
      }))
    })();

  }

}
