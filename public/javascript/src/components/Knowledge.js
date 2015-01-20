var React = require('react');

var Knowledge = React.createClass({

  getInitialState: function() {
    return {
      edit: false,
      loading: false,
      content: ''
    };
  },

  componentDidMount: function() {
    var that = this;
    $.get('/knowledge', function(data) {
      console.log(data);
      that.setState({
        content: data.content
      });
    });
  },

  handleChange: function(event) {
    this.setState({ content: event.target.value });
  },

  handleEdit: function() {
    var edit = this.state.edit;
    this.setState({ edit: !edit });
  },

  handleSave: function() {
    var edit = this.state.edit;
    var that = this;
    this.setState({ loading: true });
    console.log(this.state.content);
    $.post('/knowledge', {
      content: this.state.content
    }, function(data) {
      that.setState({
        edit: !edit,
        content: data.content,
        loading: false
      });
    });
  },

  render: function() {

    var textBox = null;
    var button = null;
    var edit = this.state.edit;

    if (edit) {
      textBox = (
        <div className="field">
          <textarea style={ { resize: 'none', minHeight: '480px' } }value={ this.state.content } onChange={ this.handleChange } />
        </div>
      );
      button = (
        <div className="ui primary button" onClick={ this.handleSave }>
        儲存
        </div>
      );
    } else {
      textBox = (
        <div className="ui tertiary segment">
          <pre>
          { this.state.content }
          </pre>
        </div>
      );
      button = (
        <div className="ui primary button" onClick={ this.handleEdit }>
        編輯
        </div>
      );
    }

    return (
      <div>
        <div className={ "ui dimmer " + (this.state.loading ? "active" : "") }>
          <div className="ui loader"></div>
        </div>
        <div className="ui form">
          { textBox }
          <div className="ui field">
            { button }
          </div>
        </div>
      </div>
    );
  }

});

module.exports = Knowledge;
