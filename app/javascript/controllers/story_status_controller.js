import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["preparation", "available", "ended", "playButton", "pauseButton"];
  static values = {
    storyid: String
  }

  connect() {
    this.createAudio();
    setInterval(() => this.createAudio(), 1000);
  }

  createAudio() {
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

  displayEndScreen() {
    this.availableTarget.hidden = true;
    this.endedTarget.hidden = false
  }

  displayAvailableScreen() {
    this.playButtonTarget.hidden = false;
    this.pauseButtonTarget.hidden = true;
    this.availableTarget.hidden = false;
    this.endedTarget.hidden = true;
  }
}
