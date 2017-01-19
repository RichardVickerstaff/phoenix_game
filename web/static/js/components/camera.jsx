var React = require('react');

module.exports = React.createClass({
  displayName:'Camera',

  render: function() {
    return (
      <a-camera position="0 0 0" >
        <a-cursor color="#FF0000" />
      </a-camera>
    );
  }
});
