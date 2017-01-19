var React    = require('react')
var ReactDOM = require('react-dom');

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
      ReactDOM.render(<h1>Test</h1>, document.getElementById('game'));
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

};
