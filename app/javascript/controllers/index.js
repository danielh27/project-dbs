// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import ChatSubscriptionController from "./chat_subscription_controller"
application.register("chat_subscription", ChatSubscriptionController)

import SearchMessagenController from "./search_message_controller"
application.register("search_message", SearchMessagenController)
