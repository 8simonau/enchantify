import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["preparation", "available"];
  static values = {
    storyid: String
  }

  connect() {
    console.log(this.storyidValue)
    setInterval(() => this.updateAudio(), 2000);
  }

  updateAudio() {
    const audio = document.querySelector("audio")
    if (audio == undefined) {
      // Get and render the audio partial
      fetch(`/stories/${this.storyidValue}/audio`)
        .then(response => {
          if (response.status === 204) {
            throw new Error("204");
          } else {
            return response.text();
          }
        })
        .then(html => {
          const fragment = document.createRange().createContextualFragment(html);
          this.availableTarget.appendChild(fragment);
          this.availableTarget.hidden = false;
          this.preparationTarget.hidden = true
        })
        .catch(error => {
          console.error("Error fetching audio:", error);
        });
    }
  }
}
