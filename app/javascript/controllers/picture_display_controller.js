import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story-display"
export default class extends Controller {
  static targets = ["pictureContainer", "picture", "audio"];
  static values = {
    playing: Boolean
  }

  connect() {
    this.pictureContainerTarget.firstElementChild.style.display = "block";
  }

  initialize() {
    this.pictureIndex = 0
  }

  play(event) {
    this.playingValue = true
    this.displayNextPicture()
  };

  pause() {
    this.playingValue = false
  }

  displayNextPicture() {
    setInterval(() => {
      if (this.playingValue == false || this.pictureIndex + 1 == this.pictureTargets.length) {
        return
      }
      this.pictureTargets[this.pictureIndex].style.display = "none";
      this.pictureTargets[this.pictureIndex + 1].style.display = "block";
      this.pictureIndex += 1
      },
      ((this.audioTarget.duration * 1000) / 4) + 1
    )
  }
}
