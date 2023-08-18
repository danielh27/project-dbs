# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "@rails/actioncable", to: "actioncable.esm.js"
# pin "@rails/activestorage", to: "activestorage.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "swiper", to: "https://ga.jspm.io/npm:swiper@10.1.0/swiper.mjs", preload: true
