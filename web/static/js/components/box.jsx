var React = require('react');

var min = -10;
var max = 10;

module.exports = React.createClass({
  displayName:'Box',

  getPosition: function(game_state) {
    return (game_state.x + " " + game_state.y + " " + game_state.z);
  },

  render: function() {
    return (
      <a-box id='abox' color={ this.props.game_state.color } position={ this.getPosition(this.props.game_state) }  >
      </a-box>
    );
  }
});
