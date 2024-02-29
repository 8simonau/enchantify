import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story-display"
export default class extends Controller {
  static targets = ["image"]

  connect() {
    console.log("heyyy");
  }
}
