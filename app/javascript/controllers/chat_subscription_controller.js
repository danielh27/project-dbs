import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number }
  static targets = ["messages", "messageHour", "test"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      { received: data => {
        this.#insertMessageAndScrollDown(data)
        this.#deleteMessageHour(data) }
      }
    );
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    this.channel.unsubscribe();
  }

  showChatList() {
    this.element.classList.toggle("d-none");
    this.element.classList.toggle("d-lg-block");
    document.querySelector("#section-chat-list").classList.toggle("d-block");
    document.querySelector("#section-chat-list").classList.toggle("d-none");
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    const messageElement = this.#buildMessageElement(currentUserIsSender, data);

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  #buildMessageElement(currentUserIsSender, data) {
    const showUserAvatar = this.messagesTarget.lastElementChild.classList.contains("justify-content-end") ? "d-none" : "avatar"
    const showProviderAvatar = this.messagesTarget.lastElementChild.classList.contains("justify-content-start") ? "d-none" : "avatar"
    const dateElement = `<div class="my-2 message-date-today d-flex align-items-center justify-content-center gap-3">
                          ${data.actual_message_date}
                        </div>`
    const hourElement = `<div data-chat-subscription-target="messageHour" class="d-flex align-items-center ${this.#setClassByUser(currentUserIsSender, 'justify-content-end right-hour', 'justify-content-start left-hour')}">
                          ${data.actual_message_hour.split(' ').at(-1)}
                        </div>`

    return `
      ${data.can_show_date ? dateElement : ''}

      <div class="message-row d-flex ${this.#setClassByUser(currentUserIsSender, "justify-content-end", "justify-content-start")}">
        <div class="avatar">
          <div class="${this.#setClassByUser(currentUserIsSender, "d-none", showProviderAvatar)} me-3">
            ${data.avatar}
          </div>
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "sender-style", "receiver-style")}">
          ${data.message}
        </div>
        <div class="avatar">
          <div class="${this.#setClassByUser(currentUserIsSender, showUserAvatar, "d-none")}">
            ${data.avatar}
          </div>
        </div>
      </div>

      ${data.can_show_hour ? hourElement : ''}
    `;
  }

  #deleteMessageHour(data) {
    if(data.actual_message_hour == data.previous_message_hour && !data.can_show_date && data.is_same_sender) {
      return this.messageHourTargets.at(-2).remove();
    }
  }

  #setClassByUser(currentUserIsSender, first_class, second_class) {
    return currentUserIsSender ? first_class : second_class;
  }
}
