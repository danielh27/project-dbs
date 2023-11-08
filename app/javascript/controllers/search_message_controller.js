import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-message"
export default class extends Controller {
  static values = { chatId: Number, chatToken: String, serviceId: Number }
  static targets = ['form', 'chats', 'input', 'counter', 'anchor']

  connect() {
    window.addEventListener('popstate', async function() {
      const currentUrl = window.location.href;
      const url = `/chats/${this.chatTokenValue}/my_chats?chat=${currentUrl.split('/').at(-1)}`;
      fetch(url, { headers: { Accept: 'text/plain' }})
      .then(response => response.text())
      .then(data => {
       document.querySelector('.chatroom').outerHTML = data;
      })
    });
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
      const chatToken = event.currentTarget.href.split('/').at(-1);
      const url = `/chats/${this.chatTokenValue}/my_chats?chat=${chatToken}`
      const response = await fetch(url, { method: 'get', headers: { Accept: 'text/plain'} });
      const data = await response.text();
      document.querySelector('.chatroom').outerHTML = data;
      this.#showChat();
      const newUrl = `${chatToken}`;
      window.history.pushState({}, '', newUrl);
    } catch (error) { console.log(error) }
  }

  #showChat() {
    this.element.classList.toggle("d-none");
    this.element.classList.toggle("d-lg-block");
    document.querySelector("#section-chats").classList.toggle("d-block");
    document.querySelector("#section-chats").classList.toggle("d-none");
  }

  // openChat(event) {
  //   event.preventDefault();
  //   const anchor = event.currentTarget;
  //   const chatId = anchor.href.split('=').at(-1);
  //   // const url = `/chats/${this.chatIdValue}/my_chats?chat=${chatId}`
  //   // const url = `/chats/${this.chatIdValue}/my_chats?chat=${chatId}`
  //   const url = anchor.href

  //   const form = new FormData()
  //   form.append('chat', chatId)
  //   fetch(url, {
  //     method: 'post',
  //     headers: { Accept: 'text/plain', 'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content},
  //     body: form
  //   }).then(response => response.text())
  //     .then(data => {
  //       document.querySelector('.chatroom').outerHTML = data;
  //       // const newUrl = `?chat=${chatId}`;
  //       // window.history.pushState({}, '', newUrl);
  //     })
  // }
}
