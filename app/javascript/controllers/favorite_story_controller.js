import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-story"
export default class extends Controller {
  static targets = ["favorite", "unfavorite"]
  connect() {
    console.log("hdllo")
  }

  toggleFavorite() {
    if (this.favoriteTarget.hidden) {
      this.favoriteTarget.hidden = false
      this.unfavoriteTarget.hidden = true
    } else {
      this.favoriteTarget.hidden = true
      this.unfavoriteTarget.hidden = false
    }
  }
}
