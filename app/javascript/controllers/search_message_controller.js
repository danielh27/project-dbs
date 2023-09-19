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

  async openChat(event) {
    event.preventDefault();
    try {
      const anchor = event.currentTarget;
      const chatId = anchor.parentElement.action.split('/').at(-1);
      const url = `/services/${this.serviceIdValue}/chats/my_chats?chat=${chatId}`;
      const response = await fetch(url, { method: 'get', headers: { Accept: 'text/plain'} });
      const data = await response.text();
      document.querySelector('.chatroom').outerHTML = data;
    } catch (error) { }
  }

  // openChat(event) {
  //   event.preventDefault();
  //   const anchor = event.currentTarget
  //   const url = `/services/${this.serviceIdValue}/chats/my_chats`
  //   const form = new FormData()
  //   form.append('chat', anchor.parentElement.action.split('/').at(-1))
  //   fetch(url, {
  //     method: 'post',
  //     headers: { Accept: 'text/plain', 'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content},
  //     body: form
  //   }).then(response => response.text())
  //     .then(data => {
  //       document.querySelector('.chatroom').outerHTML = data;
  //     })
  // }
}
