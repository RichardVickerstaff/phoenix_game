var React = require('react');
var Word = require('./word.jsx');
var Guess = require('./guess.jsx');

module.exports = React.createClass({
  displayName:'Hangman',

  render: function() {
    console.log(this.props.game_state);
    if(this.props.game_state.word_guess){
      return(
        <div id='hangman' >
          {this.props.game_state.word_guess}
          <Guess channel={this.props.channel} game_state={this.props.game_state}/>
        </div>
      );
    }else{
      return(
        <div id='hangman' >
          Please enter your word
          <Word channel={this.props.channel} game_state={this.props.game_state}/>
        </div>
      );
    }
  }
});
