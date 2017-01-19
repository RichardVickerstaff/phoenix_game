require('aframe');

var React    = require('react')
var ReactDOM = require('react-dom');
var Scene = require('./components/scene.jsx');

import "phoenix_html";
import { Socket } from "phoenix";

module.exports = function(){
  let socket = new Socket("/socket", {params: {token: window.userToken}})
  socket.connect()
  let channel = socket.channel("game:lobby", {})

  channel.on("update_state", payload => {
    ReactDOM.render(<h1>Test</h1>, document.getElementById('game'));
  })

  channel.join()
    .receive("ok", resp => {
      console.log('joined');
      ReactDOM.render(<Scene />, document.getElementById('game'));
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  var onKeydown = function (evt) {
    console.log(evt);
    if(evt.keyCode === 49){
      console.log('send event');
      channel.push("action", {body: {key_code: 49}})
    }
  };
  window.addEventListener('keydown', onKeydown);
};
