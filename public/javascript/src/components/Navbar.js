var React = require('react');

var Navbar = React.createClass({
  handleClick: function(target) {
    var that = this;
    return function() {
      that.props.onClick(target);
    }
  },
  render: function() {
    return (
      <div>
        <div className="ui fixed menu inverted">
          <a className="item" onClick={ this.handleClick('knowledge') } >
            <i className="book icon"></i>
            知識庫
          </a>
          <a className="item" onClick={ this.handleClick('problems') }>
            <i className="puzzle icon"></i>
            題庫
          </a>
        </div>
      </div>
    );
  }

});

module.exports = Navbar;
