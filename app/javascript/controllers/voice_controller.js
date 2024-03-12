import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voice"
export default class extends Controller {
  static targets = ["startRecording", "stopRecording", "recordedAudio", "audioBlob", 'timeElapsed'];

  connect() {
    this.timerInterval = null;
    this.secondsElapsed = 0;
    this.userMediaStream = null; // Initialize variable to store the stream
  }

  startRecording(event) {
    event.preventDefault()
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
        this.userMediaStream = stream; // Store the stream
        this.recorder = RecordRTC(stream, {
          type: 'audio',
          getBlob: function () {
            return blobURL2;
          },
           getRealBlob: function() {
              return blobURL;
            },
        });
        this.startRecorder(event);
      }).catch((error) => {
        console.log("The following error occurred: " + error);
        alert("Veuillez donner accès au microphone")
      });
    } else {
      alert("Votre navigateur ne supporte pas l'enregistrement audio")
    }
  }

  startRecorder (event) {
    var vm = this;
    event.preventDefault();
    this.recorder.startRecording();
    this.startRecordingTarget.disabled = true
    this.stopRecordingTarget.disabled = false
    this.startTimer();
  }

  stopRecording(event) {
    event.preventDefault()
    this.recorder.stopRecording(blob => {
      const file = new File([this.recorder.getBlob()], "audio.webm", { lastModified: new Date().getTime(), type: blob.type })
      const container = new DataTransfer();
      container.items.add(file);
      this.audioBlobTarget.files = container.files;
    });

    if (this.userMediaStream) {
      this.userMediaStream.getTracks().forEach(track => track.stop()); // Stop the tracks associated with the stream
      this.userMediaStream = null; // Clear the stored stream

    }
    this.startRecordingTarget.disabled = false
    this.stopRecordingTarget.disabled = true
    this.stopTimer();
    this.secondsElapsed = 0;
  }

  openRecorder () {
    return (this.stopRecordingTarget.disabled == false);
  }

  startTimer () {
    var vm = this;
    this.timerInterval = setInterval(() => {
      vm.secondsElapsed = vm.secondsElapsed + 1;
      vm.setTime();
    }, 1000);
  }

  stopTimer () {
    var vm = this;
    clearInterval(vm.timerInterval);
  }

  setTime () {
    this.timeElapsedTarget.innerHTML = `Durée: ${this.getTimeString(this.secondsElapsed)} sec.`;
  }

  getTimeString(seconds) {
    let hours = Math.floor(seconds / 3600);
    let minutes = Math.floor((seconds % 3600) / 60);
    let remainingSeconds = seconds % 60;

    // Add leading zeroes to hours, minutes, and seconds if needed
    hours = hours < 10 ? "0" + hours : hours;
    minutes = minutes < 10 ? "0" + minutes : minutes;
    remainingSeconds = remainingSeconds < 10 ? "0" + remainingSeconds : remainingSeconds;

    return `${remainingSeconds}`;
    // return `${hours}:${minutes}:${remainingSeconds}`;
  }
}
