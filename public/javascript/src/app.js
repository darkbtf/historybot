
var React = require('react');

var Navbar = require('./components/Navbar');
var Main = require('./components/Main');

var App = React.createClass({
  handleClick: function(target) {
    this.refs.content.setState({
      content: target
    });
  },
  render: function() {
    return (
      <div>
        <Navbar onClick={ this.handleClick }/>
        <Main ref="content" />
      </div>
    );
  }
});

React.render(
  <App />,
  document.getElementById('app')
);
//$('.ui.modal').modal('show');
