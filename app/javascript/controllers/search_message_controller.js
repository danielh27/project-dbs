import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-message"
export default class extends Controller {
  static targets = ['form', 'messages', 'input']

  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.messagesTarget)
  }

  filter() {
    const url = `${this.formTarget.action}?query=${this.inputTarget}`
    fetch(url, { headers: { Accept: 'text/plain' }})
      .then(response => response.text())
      .then(data => {
        console.log(data)
      })
  }
  // por lo que usamos components habra que sacar rpta en json y noo text sino quiza
  // poner en vez de partial en contrlller rb poner template ver en google com oseria
}
