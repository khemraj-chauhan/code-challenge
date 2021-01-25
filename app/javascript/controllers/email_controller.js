import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['error']

  connect() {
    this.errorTarget.style.display = 'none'
  }

  validate(event) {
    let message = 'Invalid email, email should belongs to @getmainstreet.com domain'
    let email = event.target.value

    if(!email.endsWith('@getmainstreet.com')) {
      this.errorTarget.innerHTML = message
      this.errorTarget.style.display = 'block'
    } else {
      this.errorTarget.innerHTML = ''
      this.errorTarget.style.display = 'none'
    }
  }
}
