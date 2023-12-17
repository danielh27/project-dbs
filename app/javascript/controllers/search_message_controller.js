import { Controller } from "@hotwired/stimulus"
import ApiService from "../api/api_service"

// Connects to data-controller="search-message"
export default class extends Controller {
  static values = { chatId: Number, chatToken: String, serviceId: Number }
  static targets = ['form', 'chats', 'input', 'counter']

  connect() {
    window.addEventListener('popstate', this.restorationVisit.bind(this));
  }

  async filter() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    const data = await ApiService.get(url);
    this.chatsTarget.outerHTML = data;
    this.counterTarget.innerText = document.querySelectorAll('.chat-detail').length;
  }

  async restorationVisit() {
    const currentUrl = window.location.href;
    const url = `/chats/${this.chatTokenValue}/my_chats?chat=${currentUrl.split('/').at(-1)}`;
    const data = await ApiService.get(url);
    document.querySelector('.chatroom').outerHTML = data;
  }

  async openChat(event) {
    event.preventDefault();
    const chatToken = event.currentTarget.href.split('/').at(-1);
    const url = `/chats/${this.chatTokenValue}/my_chats?chat=${chatToken}`;
    const data = await ApiService.get(url);
    document.querySelector('.chatroom').outerHTML = data;
    document.querySelector('.bg-theme').classList.toggle('bg-theme');
    event.target.closest(".chat-detail").classList.add('bg-theme');
    this.#showChat();
    const newUrl = `${chatToken}`;
    window.history.pushState({}, '', newUrl);
  }

  #showChat() {
    this.element.classList.toggle("d-none");
    this.element.classList.toggle("d-lg-block");
    document.querySelector("#section-chats").classList.toggle("d-lg-block");
    document.querySelector("#section-chats").classList.toggle("d-none");
  }
}
