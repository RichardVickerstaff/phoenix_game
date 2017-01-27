var React = require('react');

module.exports = React.createClass({
  displayName:'Word',

  handle_submit: function(event){
    event.preventDefault();
    var input = document.getElementById('word-input');
    var value = input.value;
    input.disabled = true;
    input.value = "";

    this.props.channel.push("setup", {body: {word: value, game_id: this.props.game_state.id}})
  },

  render: function() {
    return (
      <div id='word' >
        <form onSubmit={this.handle_submit}>
          <label>
            Word:
            <input id='word-input' type="text" name="name" />
          </label>
          <input type="submit" value="Submit" />
      </form>
    </div>
    );
  }
});
