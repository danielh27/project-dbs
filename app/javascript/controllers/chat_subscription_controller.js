import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    // Logic to know if the sender is the current_user
    const currentUserIsSender = this.currentUserIdValue === data.sender_id

    // Creating the whole message from the `data.message` String
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.avatar)

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  #buildMessageElement(currentUserIsSender, message, avatar) {
    return `
      <div class="message-row d-flex ${this.#setClassByUser(currentUserIsSender, "justify-content-end", "justify-content-start")}">
        <div class="${this.#setClassByUser(currentUserIsSender, "avatar", "d-none")}">
          ${avatar}
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "sender-style", "receiver-style")}">
          ${message}
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "d-none", "avatar")}">
          ${avatar}
        </div>
      </div>
    `
  }

  // #justifyClass(currentUserIsSender) {
  // return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  // }

  // #userStyleClass(currentUserIsSender) {
  //   return currentUserIsSender ? "sender-style" : "receiver-style"
  // }

  #setClassByUser(currentUserIsSender, first_class, second_class) {
    return currentUserIsSender ? first_class : second_class
  }
}
