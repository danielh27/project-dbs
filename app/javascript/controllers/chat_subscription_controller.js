import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number, providerId: Number }
  static targets = ["messages", "providerStatus", "messageHour"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      { received: data => {
        this.#insertMessageAndScrollDown(data)
        this.#deleteMessageHour(data) }
      }
    );

    // this.channelUser = createConsumer().subscriptions.create(
    //   { channel: "AppearanceChannel", provider_id: this.providerIdValue, current_user: this.currentUserIdValue },
    //   { received: (data) => this.#setUserStatus(data) }
    // );
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    this.channel.unsubscribe();
  }

  #setUserStatus(data) {
    // console.log(data)
    // console.log(data.active)
    // this.providerStatusTarget.innerHTML = data.active ? 'Conectado' : 'Desconectado';
  }

  #insertMessageAndScrollDown(data) {
    // Logic to know if the sender is the current_user
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;

    // Creating the whole message from the `data.message` String
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
// en el chat helkpoer falta logica de hora con user distinto
// las horas transcurridas en el mesaje del chat
// en vistas mobile y tablet hacer lo de los clicks que uno se vea y el otro despaarezca

// actualizar la rama con lo que pusheo maricus y que funcione el chgat
// revisar el funconamineto del websocket por que se activa en todas las paginas
