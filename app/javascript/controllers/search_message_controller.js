import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-message"
export default class extends Controller {
  static values = { chatId: Number, serviceId: Number }
  static targets = ['form', 'chats', 'input', 'counter', 'anchor', 'hello']
  connect() {
  }

  filter() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { Accept: 'text/plain' }})
      .then(response => response.text())
      .then(data => {
        this.chatsTarget.outerHTML = data;
        this.counterTarget.innerText = document.querySelectorAll('.chat-detail').length
      })
  }

  openChat(event) {
    event.preventDefault();
    const anchor = event.currentTarget.href
    // console.log(anchor)
    const url = `services/${this.serviceIdValue}/my_chats`
    // console.log(url)

    fetch(url, { headers: { Accept: 'text/plain' }})
      .then(response => response.text())
      .then(data => {
        console.log(this.helloTarget)

      })
  }
}
