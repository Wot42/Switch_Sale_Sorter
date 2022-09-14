import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ajax-undo"
export default class extends Controller {
  connect() {
    console.log("board")
  }
  deleteBanToRuby(event) {
    event.preventDefault()


    let hamerId=event.target.dataset.hammer

  const hash ={
    BanHammer: {

    }
  }

  this.csrfToken = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute("content");

  fetch(`${window.location.protocol}/hammers/${hamerId}`, {
    method: "DELETE",
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
