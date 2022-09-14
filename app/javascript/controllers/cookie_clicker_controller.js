import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cookie-clicker"
export default class extends Controller {
  connect() {
    console.log("crumble")
  }

  filterSet(event){
    let filterId=event.target.dataset.filter

    const hash ={
      filter:  filterId

    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

    fetch(`${window.location.protocol}${window.location.host}/filter`, {
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
    .then(location.reload());
  }

  filterClear(event){

    const hash ={


    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

    fetch(`${window.location.protocol}${window.location.host}/clearfilter`, {
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
    .then(location.reload());
  }

  sortSet(event){
    let sortId=event.target.dataset.sort

    const hash ={
      sort:  sortId

    }
    console.log(sortId)

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

    fetch(`${window.location.protocol}${window.location.host}/sort`, {
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
    .then(location.reload());
  }

  sortClear(event){

    const hash ={


    }

    this.csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

    fetch(`${window.location.protocol}${window.location.host}/clearsort`, {
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
    .then(location.reload());
  }
}
