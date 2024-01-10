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
    const url = `/chats/${this.chatTokenValue}/my_chats?chat=${this.#getToken(currentUrl)}`;
    const data = await ApiService.get(url);
    const chatElement = Array.from(document.querySelectorAll('.chat-detail')).find((chatContainer) => {
      return this.#getToken(chatContainer.href) === this.#getToken(currentUrl);
    });
    this.#actionsAfterPositiveRequest(data, chatElement);
  }

  async openChat(event) {
    event.preventDefault();
    const chatToken = this.#getToken(event.currentTarget.href);
    const url = `/chats/${this.chatTokenValue}/my_chats?chat=${chatToken}`;
    const data = await ApiService.get(url);
    this.#actionsAfterPositiveRequest(data, event.target.closest(".chat-detail"));
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

  #getToken(url) {
    return url.split('/').at(-1);
  }

  #actionsAfterPositiveRequest(requestContent, actualChatElement) {
    document.querySelector('.chatroom').outerHTML = requestContent;
    document.querySelector('.bg-theme').classList.remove('bg-theme');
    actualChatElement.classList.add('bg-theme');
  }
}
