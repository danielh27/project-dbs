import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number, providerId: Number }
  static targets = ["messages", "statusUser"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    );

    this.channel = createConsumer().subscriptions.create(
      { channel: "AppearanceChannel", provider_id: this.currentUserIdValue },
      { received: (data) => {



          this.#setUserStatus(data)
        }
      }
    );
  }

  resetForm(event) {
    event.target.reset();
  }

  toggleQuotations(event) {
    event.preventDefault();
    const quotations = document.querySelector('#section-quotations');
    const chats = document.querySelector('#section-chats');

    quotations.classList.toggle('d-none');
    chats.classList.toggle('col-6');
    chats.classList.toggle('col-9');
  }

  disconnect() {
    this.channel.unsubscribe();
  }

  #setUserStatus(data) {
    console.log(data)
    data.active? this.statusUserTarget.innerHTML = 'Conectado' : this.statusUserTarget.innerHTML = 'Desconectado';
  }

  #insertMessageAndScrollDown(data) {
    // Logic to know if the sender is the current_user
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;

    // Creating the whole message from the `data.message` String
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.avatar);

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  #buildMessageElement(currentUserIsSender, message, avatar) {
    return `
      <div class="message-row d-flex ${this.#setClassByUser(currentUserIsSender, "justify-content-end", "justify-content-start")}">
        <div class="${this.#setClassByUser(currentUserIsSender, "d-none", "avatar")} me-3">
          ${avatar}
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "sender-style", "receiver-style")}">
          ${message}
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "avatar", "d-none")} ms-3">
          ${avatar}
        </div>
      </div>
    `;
  }

  #setClassByUser(currentUserIsSender, first_class, second_class) {
    return currentUserIsSender ? first_class : second_class;
  }
}
