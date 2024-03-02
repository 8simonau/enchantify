import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story-display"
export default class extends Controller {
  static targets = ["pictureContainer", "picture"];
  static values = {
    playing: Boolean
  }

  connect() {
    this.getAudioDuration()
    this.pictureContainerTarget.firstElementChild.style.display = "block";
  }

  initialize() {
    this.pictureIndex = 0
  }

  getAudioDuration() {
    const audio = document.getElementById("audio-player")
  }

  play(event) {
    this.playingValue = true
    this.displayNextPicture()
  };

  pause() {
    console.log("paused");
    this.playingValue = false
  }

  displayNextPicture() {
    setInterval(() => {
      if (this.playingValue == false || this.pictureIndex + 1 == this.pictureTargets.length) {
        return
      }
      console.log(this.pictureIndex);
      this.pictureTargets[this.pictureIndex].style.display = "none";
      this.pictureTargets[this.pictureIndex + 1].style.display = "block";
      this.pictureIndex += 1
      },
      10000
    )
  }
}
