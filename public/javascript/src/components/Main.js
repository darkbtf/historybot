var React = require('react');

var Knowledge = require('./Knowledge');
var Problems = require('./Problems');

var Main = React.createClass({
  getInitialState: function() {
    return {
      content: 'knowledge'
    };
  },
  render: function() {

    var styles = {
      marginTop: '70px',
      width: '1080px',
      marginLeft: 'auto',
      marginRight: 'auto'
    };

    var contentDOM = null;
    var content = this.state.content;

    if (content === 'knowledge') {
      contentDOM = <Knowledge />;
    } else {
      contentDOM = <Problems />;
    }

    return (
      <div style={ styles } className="ui stacked segment">
        { contentDOM }
      </div>
    );
  }

});

module.exports = Main;
