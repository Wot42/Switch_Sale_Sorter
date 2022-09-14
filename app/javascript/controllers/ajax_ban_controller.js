import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ajax-ban"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    console.log("stimulateing")
  }


  fullBanToRuby(event) {
    event.preventDefault()

    let gamesId=event.target.dataset.game
    let userId=event.target.dataset.user

    const hash ={
      BanHammer: {
        user_id: userId,
        game_id: gamesId,
        perma_ban: true,
        owned: false
      }
    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");
    console.log(window.location.protocol)
    console.log(window.location.host)

    fetch(`${window.location.protocol}/games/${gamesId}/banhammers`, {
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


    event.target.parentElement.parentElement.parentElement.style.display="none"
  }

}
