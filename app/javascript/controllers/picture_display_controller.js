import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story-display"
export default class extends Controller {
  static targets = ["pictureContainer", "picture", "audio"];
  static values = {
    playing: Boolean
  }

  connect() {
    this.pictureContainerTarget.firstElementChild.hidden = false;
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
      this.pictureTargets[this.pictureIndex].hidden = true
      this.pictureTargets[this.pictureIndex + 1].hidden = false
      this.pictureIndex += 1
      },
      ((this.audioTarget.duration * 1000) / 4) + 1
    )
  }
}
