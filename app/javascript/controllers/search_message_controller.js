import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-message"
export default class extends Controller {
  static values = { chatId: Number, serviceId: Number }
  static targets = ['form', 'chats', 'input', 'counter', 'anchor']
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
    const anchor = event.currentTarget
    console.log(anchor.parentElement.action.split('/').at(-1))
    const url = `/services/${this.serviceIdValue}/chats/my_chats`
    let form = new FormData()
    form.append('hola', anchor.parentElement.action.split('/').at(-1))
    fetch(url, {
      method: 'post',
      headers: { Accept: 'text/plain', "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content},
      body: form
    })
      .then(response => response.text())
      .then(data => {
        // console.log(data)
        // document.querySelector('.chatroom').innerText = data;
        // document.querySelector('.chatroom').outerHTML = data;
      })
  }
}
