var React = require('react');

var Box = require('./box.jsx');
var Camera = require('./camera.jsx');

module.exports = React.createClass({
  displayName:'Scene',

  render: function() {
    return (
      <a-scene>
        <Box game_state={this.props.game_state}/>
        <Camera />
      </a-scene>
    );
  }
});
