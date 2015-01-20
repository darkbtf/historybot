var React = require('react');

var Problems = React.createClass({
  getInitialState: function() {
    return {
      problems: [],
      title: '',
      id: '',
      content: '',
      result: ''
    };
  },
  componentWillMount: function() {
    var that = this;
    $.get('/problems', function(data) {
      that.setState({
        problems: data
      });
    });
    //$('.ui.quiz.modal').modal('show');
  },

  handleClick: function(index) {
    var that = this;
    return function() {
      var problems = that.state.problems;
      that.setState({
        id: problems[index].id,
        title: problems[index].title
      });

      $.get('/problem/' + problems[index].id, function(data) {
        console.log(data);
        that.setState({
          edit: false,
          content: data.content
        });
      });
    };
  },

  edit: function(event) {
    this.setState({ edit: !this.state.edit });
  },

  save: function(id) {
    var that = this;
    return function() {
      $.post('/problem/' + id, { content: that.state.content }, function(data) {
        that.setState({ edit: !that.state.edit, content: data.content });
      });
    };
  },

  run: function(id) {
    var that = this;
    return function() {
      $.get('/run/' + id, function(data) {
          console.log(data);
          that.setState({ result: data.result });
          $('.result.modal').modal({
            detachable: false
          }).modal('show');
      });
    }
  },
  handleChange: function(event) {
    this.setState({ content: event.target.value });
  },
  render: function() {

    var problems = this.state.problems;

    var problemList = [];
    for (var i = 0; i < problems.length; ++i) {
      problemList.push(
        <div className="item" onClick={ this.handleClick(i) }>
          <div className="content" >
            <div className="header">{ problems[i].title }</div>
            </div>
        </div>
      );
      console.log(problems[i].title);
    }

    var img = null;
    if (this.state.id) {
      img = (
        <img className="ui image" src={ '/images/' + this.state.id + '.png' } />
      );
    }

    var textBox = null;
    var editButton = null;
    if (this.state.edit) {
      textBox = (
        <textarea style={ { resize: 'none', minHeight: '220px', minWidth: '880px' } } value={ this.state.content } onChange={ this.handleChange } />
      );
      editButton = (
        <div className="ui blue button" onClick={ this.save(this.state.id) }>
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
      editButton = (
        <div>
          <div className="ui blue button" onClick={ this.edit }>
            編輯
          </div>
          <div className="ui green button" onClick={ this.run(this.state.id) } >
            執行
          </div>
        </div>
      );
    }

    return (
      <div>
        <div className="ui grid">
          <div className="two wide column">
            <div className="ui selection list">
              { problemList }
            </div>
          </div>
          <div className="fourteen wide column">
            <h2 className="header">
              { this.state.title }
            </h2>
            <div>
              { img }
            </div>
            { textBox }
            { editButton }
            <div className="ui tertiary segment">
              <pre>
                { this.state.result }
              </pre>
            </div>

          </div>
        </div>
      </div>
    );
  }

});

module.exports = Problems;
