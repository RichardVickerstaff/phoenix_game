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
    ReactDOM.render(<Scene game_state={payload}/>, document.getElementById('game'));
  })

  channel.join()
    .receive("ok", resp => {
      ReactDOM.render(<Scene game_state={resp}/>, document.getElementById('game'));
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  var onKeydown = function (evt) {
    channel.push("action", {body: {key_code: evt.keyCode}})
  };
  window.addEventListener('keydown', onKeydown);
};
