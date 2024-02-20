import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-child"
export default class extends Controller {
  static targets = ["form"]

  connect() {
  }

  revealForm() {
    this.formTarget.classList.remove("d-none")
  }
}
