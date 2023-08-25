import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number, providerId: Number }
  static targets = ["messages", "providerStatus"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
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
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.avatar);

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  #buildMessageElement(currentUserIsSender, message, avatar) {
    const showUserAvatar = this.messagesTarget.lastElementChild.classList.contains("justify-content-end") ? "d-none" : "avatar"
    const showProviderAvatar = this.messagesTarget.lastElementChild.classList.contains("justify-content-start") ? "d-none" : "avatar"
    return `
      <div class="message-row d-flex ${this.#setClassByUser(currentUserIsSender, "justify-content-end", "justify-content-start")}">
        <div class="avatar">
          <div class="${this.#setClassByUser(currentUserIsSender, "d-none", showProviderAvatar)} me-3">
            ${avatar}
          </div>
        </div>
        <div class="${this.#setClassByUser(currentUserIsSender, "sender-style", "receiver-style")}">
          ${message}
        </div>
        <div class="avatar">
          <div class="${this.#setClassByUser(currentUserIsSender, showUserAvatar, "d-none")}">
            ${avatar}
          </div>
        </div>
      </div>

      <div class="d-flex align-items-center ${this.#setClassByUser(currentUserIsSender, 'justify-content-end right-hour', 'justify-content-start left-hour')}">
        <% if show_hour?(message, chat.messages, index) %>
          <%= message.created_at.strftime("%H:%M") %>
        <% end %>
      </div>
    `;
  }

  #setClassByUser(currentUserIsSender, first_class, second_class) {
    return currentUserIsSender ? first_class : second_class;
  }

  #formatDate(date) {
    const day = date.getDate();
    const month = date.getMonth() + 1; // months in js is from 0 to 11
    const year = date.getFullYear();
    const hours = date.getHours();
    const minutes = date.getMinutes();

    return `${day}/${month}/${year} ${hours}:${minutes}`;
  }

  #showHour(message, messages, index) {
    return (message_date_different_to_previous_message?(message, messages, index) &&
     message_date_different_to_next_message?(message, messages, index) && sender?(message.sender, current_user)) ||
      (message_date_equal_to_previous_message?(message, messages, index) &&
      message_date_different_to_next_message?(message, messages, index) && sender?(message.sender, current_user)) ||
      !sender?(message.sender, current_user)
  }

  #messageDateDifferentToPreviousMessage(message, messages, index) {
    return formatDate()message.created_at.strftime("%-d/%m/%Y %H:%M") != messages[index - 1].created_at.strftime("%-d/%m/%Y %H:%M")
  }

  #messageDateDifferentToNextMessage(message, messages, index) {
    return message.created_at.strftime("%-d/%m/%Y %H:%M") != messages[index + 1]&.created_at&.strftime("%-d/%m/%Y %H:%M")
  }

  #messageDateEqualToPreviousMessage(message, messages, index) {
    return message.created_at.strftime("%-d/%m/%Y %H:%M") == messages[index - 1].created_at.strftime("%-d/%m/%Y %H:%M")
  }
}
// ver lo de la lista no esta primero el mensae mas actual, quiza neecsito mas js y mejorar query
// anadir la logica de l ahora alli arriba cuando se anade el mensaje, faslta la loica del helper
// anadir la fecha con la linea en el mismo metodo de arriuiba
// actualizar la rama con lo que pusheo maricus y que funcione el chgat

// revisar el funconamineto del websocket por que se activa en todas las paginas

// messages[index - 1] para conseguir este y el +1 hay que pasarlo literal cada uno por el controller en el broadcast
// del websocket
// creo que mejor me paso las horas desde le wbsocket, incluyendo el index -1 y +1
