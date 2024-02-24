import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="option-selection"
export default class extends Controller {
  static targets = ["tickmarks"]

  connect() {
  }

  toggle() {
    this.tickmarksTarget.classList.toggle("hidden-tickmark")
  }
}
