import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static targets = ["audio", "playButton", "pauseButton", "currentTime", "totalTime", "progress", "progressBar", "favorite", "unfavorite"]
  connect() {
  }

  play() {
    this.audioTarget.play()
    this.playButtonTarget.hidden = true
    this.pauseButtonTarget.hidden = false
  }

  pause() {
    this.audioTarget.pause()
    this.playButtonTarget.hidden = false
    this.pauseButtonTarget.hidden = true
  }

  getDuration() {
    const duration = this.audioTarget.duration
    this.totalTimeTarget.innerHTML = this.formatSeconds(duration)
  }

  timeUpdate() {
    const duration = this.audioTarget.duration
    const currentTime = this.audioTarget.currentTime
    const playPercent = currentTime / duration
    const totalWidth = this.progressBarTarget.offsetWidth
    const progressWidth = playPercent * totalWidth + "px"

    this.progressTarget.style.width = progressWidth

    this.currentTimeTarget.innerHTML = this.formatSeconds(this.audioTarget.currentTime)
  }

  formatSeconds(timeInSeconds) {
    return new Date(null, null, null, null, null, timeInSeconds).toTimeString().match(/\d{2}:(\d{2}:\d{2})/)[1]
  }

  setPlayTime(e) {
  let posX = e.pageX - this.progressBarTarget.getBoundingClientRect().left;
  const totalWidth = this.progressBarTarget.offsetWidth
  const playPercent = posX / totalWidth
  const duration = this.audioTarget.duration
  this.audioTarget.currentTime = playPercent * duration
  this.audioTarget.play()
  }
}
