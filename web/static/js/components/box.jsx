var React = require('react');

var min = -10;
var max = 10;

module.exports = React.createClass({
  displayName:'Box',

  random: function() {
    return (Math.floor(Math.random() * (max - min + 1)) + min);
  },

  getInitialState : function() {
    return { 
      color : "#6173F4",
      x: 0,
      y: 0,
      z: -5
    };
  },

  click: function() {
    this.setState({ x : this.random() } );
    this.setState({ y : this.random() } );
    this.setState({ z : -10 * Math.random() } );
    et.emit('score');
  },

  getPosition: function() {
    return (this.state.x + " " + this.state.y + " " + this.state.z);
  },

  render: function() {
    return (
      <a-box id='abox' color={ this.state.color } position={ this.getPosition() }  onClick={ this.click } >
      </a-box>
    );
  }
});
