document.addEventListener("DOMContentLoaded", theDOMHasLoaded);
window.setInterval(printTime,1);
window.setInterval(currentPlay, 1);

var audioList = [];
var componentDict = {};
var playingAudio = null;
var onplayhead = null;

function AudioObject(audio, duration) {
  this.audio = audio;
  this.id = audio.id;
  this.duration = duration;
}

AudioObject.prototype.bindAudioPlayer = function (num) {
  this.audioplayer = document.getElementById("audioplayer-" + num);
  this.playbutton = document.getElementById("playbutton-" + num);
  this.timeline = document.getElementById("timeline-" + num);
  this.playhead = document.getElementById("playhead-" + num);
  this.timelineWidth = this.timeline.offsetWidth - this.playhead.offsetWidth
}

AudioObject.prototype.addEventListeners = function () {
  this.audio.addEventListener(
    "timeupdate", AudioObject.prototype.timeUpdate, false
  );
  this.audio.addEventListener(
    "durationchange", AudioObject.prototype.durationChange, false
  );
  this.timeline.addEventListener(
    "click", AudioObject.prototype.timelineClick, false
  );
  this.playbutton.addEventListener(
    "click", AudioObject.prototype.pressPlay, false
  );
  this.playhead.addEventListener(
    'mousedown', AudioObject.prototype.mouseDown, false
  );
  window.addEventListener('mouseup', mouseUp, false);
}

function populateAudioList() {
  var audioElements = document.getElementsByClassName("audio");
  for (i = 1; i <= audioElements.length; i++) {
    audioList.push(
      new AudioObject(audioElements[i-1], 0)
    );
    num = audioList[i-1].id.replace("audio-", "")
    audioList[i-1].bindAudioPlayer(num);
    audioList[i-1].addEventListeners();
  }
}

function populateComponentDictionary() {
  for (i = 0; i < audioList.length; i++) {
    componentDict[audioList[i].audio.id] = i;
    componentDict[audioList[i].playbutton.id] = i;
    componentDict[audioList[i].timeline.id] = i;
    componentDict[audioList[i].playhead.id] = i;
  }
}

AudioObject.prototype.durationChange = function () {
  var ao = audioList[getAudioListIndex(this.id)];
  ao.duration = this.duration;
}

AudioObject.prototype.pressPlay = function () {
  var index = getAudioListIndex(this.id);
  audioList[index].play();
}

AudioObject.prototype.play = function () {
  if (this == playingAudio) {
    playingAudio = null;
    this.audio.pause();
    changeClass(this.playbutton, "playbutton play");
  }
  else {
    if (playingAudio != null) {
      playingAudio.audio.pause();
      changeClass(playingAudio.playbutton, "playbutton play");
    }
    this.audio.play();
    playingAudio = this;
    changeClass(this.playbutton, "playbutton pause");
  }
}

AudioObject.prototype.timelineClick = function (event) {
  var ao = audioList[getAudioListIndex(this.id)];
  ao.audio.currentTime = ao.audio.duration * clickPercent(
    event, ao.timeline, ao.timelineWidth
  );
}

AudioObject.prototype.mouseDown = function (event) {
  onplayhead = this.id;
  var ao = audioList[getAudioListIndex(this.id)];
  window.addEventListener(
    'mousemove', AudioObject.prototype.moveplayhead, true
  );
  ao.audio.removeEventListener(
    'timeupdate', AudioObject.prototype.timeUpdate, false
  );
}

function mouseUp(e) {
  if (onplayhead != null) {
    var ao = audioList[getAudioListIndex(onplayhead)];
    window.removeEventListener(
      'mousemove', AudioObject.prototype.moveplayhead, true
    );
    ao.audio.currentTime = ao.audio.duration * clickPercent(
      e, ao.timeline, ao.timelineWidth
    );
    ao.audio.addEventListener(
      'timeupdate', AudioObject.prototype.timeUpdate, false
    );
  }
  onplayhead = null;
}

AudioObject.prototype.moveplayhead = function (e) {
  var ao = audioList[getAudioListIndex(onplayhead)];
  var newMargLeft = e.pageX - ao.timeline.offsetLeft;
  if (newMargLeft >= 0 && newMargLeft <= ao.timelineWidth) {
    document.getElementById(onplayhead).style.marginLeft = newMargLeft + "px";
  }
  if (newMargLeft < 0) {
    playhead.style.marginLeft = "0px";
  }
  if (newMargLeft > ao.timelineWidth) {
    playhead.style.marginLeft = ao.timelineWidth + "px";
  }
}

AudioObject.prototype.timeUpdate = function () {
  var ao = audioList[getAudioListIndex(this.id)];
  var playPercent = ao.timelineWidth * (ao.audio.currentTime / ao.duration);
  ao.playhead.style.marginLeft = playPercent + "px";
  if (ao.audio.currentTime == ao.duration) {
    changeClass(ao.playbutton, "playbutton play");
    ao.audio.currentTime = 0;
    ao.audio.pause();
    playingAudio = null;
  }
}

function printTime() {
  var audioElements = document.getElementsByClassName("audio");
  for (i = 1; i <= audioElements.length; i++) {
    var ao = audioList[i-1];
    var num = audioList[i-1].id.replace("audio-", "");
    duration = parseInt(ao.audio.duration);
    var d = moment.duration(duration, 'seconds');
    var hours = Math.floor(d.asHours());
    var mins = Math.floor(d.asMinutes()) - hours * 60;
    var secs = Math.floor(d.asSeconds()) - hours * 3600 - mins * 60;
    if (hours != 0) {
      document.getElementById("stop-time-" + num).innerHTML =
        hours + ':' + mins + ':' + secs;
    }
    else
      document.getElementById("stop-time-" + num).innerHTML =
        mins + ':' + secs;
  }
}

function currentPlay() {
  var audioElements = document.getElementsByClassName("audio");
  for (i = 1; i <= audioElements.length; i++) {
    var ao = audioList[i-1];
    var num = audioList[i-1].id.replace("audio-", "");
    duration = parseInt(ao.audio.currentTime);
    var d = moment.duration(duration, 'seconds');
    var hours = Math.floor(d.asHours());
    var mins = Math.floor(d.asMinutes()) - hours * 60;
    var secs = Math.floor(d.asSeconds()) - hours * 3600 - mins * 60;
    if (hours != 0) {
      document.getElementById("start-time-" + num).innerHTML =
        hours + ':' + mins + ':' + secs;
    }
    else
      document.getElementById("start-time-" + num).innerHTML =
        mins + ':' + secs;
  }
}

function changeClass(element, newClasses) {
  element.className = newClasses;
}

function getAudioListIndex(id) {
  return componentDict[id];
}

function clickPercent(e, timeline, timelineWidth) {
  return (e.pageX - timeline.offsetLeft) / timelineWidth;
}

function theDOMHasLoaded(e) {
  populateAudioList();
  populateComponentDictionary();
}
