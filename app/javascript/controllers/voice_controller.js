import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voice"
export default class extends Controller {
  static targets = ["startRecording", "stopRecording", "recordedAudio", "audioBlob", 'timeElapsed'];
  // static targets = ["startRecording", "stopRecording", 'resumeRecording', 'pauseRecording', "recordedAudio", "audioBlob", 'timeElapsed'];

  connect() {
    this.timerInterval = null;
    this.secondsElapsed = 0;
  }

  startRecording(event) {
    event.preventDefault()
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
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
        alert("Please grant permission for microphone access")
      });
    } else {
      alert("Your browser does not support audio recording, please use a different browser or update your current browser")
    }
  }

  // pauseRecording (event) {
  //   event.preventDefault();
  //   this.recorder.pauseRecording()
  //   this.startRecordingTarget.disabled = true
  //   this.stopRecordingTarget.disabled = false
  //   // this.pauseRecordingTarget.disabled = true;
  //   // this.resumeRecordingTarget.disabled = false;
  //   this.stopTimer();
  // }

  // resumeRecording (event) {
  //   event.preventDefault();
  //   this.recorder.resumeRecording()
  //   this.startRecordingTarget.disabled = true
  //   this.stopRecordingTarget.disabled = false
  //   this.pauseRecordingTarget.disabled = false;
  //   this.resumeRecordingTarget.disabled = true;
  //   this.startTimer();
  // }

  startRecorder (event) {
    var vm = this;
    event.preventDefault();
    this.recorder.startRecording();
    this.startRecordingTarget.disabled = true
    this.stopRecordingTarget.disabled = false
    // this.pauseRecordingTarget.disabled = false;
    this.startTimer();
  }

  stopRecording(event) {
    event.preventDefault()
    this.recorder.stopRecording(blob => {

      console.log(this.audioBlobTarget)
      const file = new File([this.recorder.getBlob()], "audio.webm", { lastModified: new Date().getTime(), type: blob.type })
      const container = new DataTransfer();
      container.items.add(file);
      this.audioBlobTarget.files = container.files;
    });
    this.startRecordingTarget.disabled = false
    this.stopRecordingTarget.disabled = true
    // this.pauseRecordingTarget.disabled = true;
    // this.resumeRecordingTarget.disabled = true;
    this.stopTimer();
    this.secondsElapsed = 0;
  }


  // blobToFile(theBlob, fileName){
  //     return new File([theBlob], fileName, { lastModified: new Date().getTime(), type: theBlob.type })
  // }

  // appendFormData (formData) {
  //   if (!this.recorder) return formData;
  //   var fieldName = this.audioBlobTarget.name;
  //   console.log('fieldName:', fieldName);

  //   if (this.recorder.getBlob())
  //     formData.append(fieldName, this.recorder.getBlob(), (new Date()).getTime() + ".webm");

  //   return formData;
  // }

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
    this.timeElapsedTarget.innerHTML = `Duration: ${this.getTimeString(this.secondsElapsed)} seconds`;
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