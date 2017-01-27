var React    = require('react')
var ReactDOM = require('react-dom');
var Hangman = require('./components/hangman.jsx');

import "phoenix_html";
import { Socket } from "phoenix";

module.exports = function(){
  let socket = new Socket("/socket", {params: {token: window.userToken}})
  socket.connect()
  var game_id = document.querySelector('meta[name="game_id"]').content;
  let channel = socket.channel("game:" + game_id, {})

  channel.on("update_state", payload => {
    ReactDOM.render(<Hangman channel={channel} game_state={payload}/>, document.getElementById('game'));
  })

  channel.join()
    .receive("ok", resp => {
      ReactDOM.render(<Hangman channel={channel} game_state={resp}/>, document.getElementById('game'));
    })
    .receive("error", resp => { console.log("Unable to join", resp) })
};
