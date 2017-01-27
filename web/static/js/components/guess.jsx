var React = require('react');

module.exports = React.createClass({
  displayName:'guess',

  handle_submit: function(event){
    event.preventDefault();
    var input = document.getElementById('guess-input');
    var value = input.value;
    input.value = "";

    this.props.channel.push("guess", {body: {guess: value, game_id: this.props.game_state.game_id}})
  },

  render: function() {
    return (
      <div id='word' >
        Guess: {this.props.game_state.guesses}
        <form onSubmit={this.handle_submit}>
          <label>
            Guess:
            <input id='guess-input' type="text" name="name" maxLength="1" />
          </label>
          <input type="submit" value="Submit" />
      </form>
    </div>
    );
  }
});
