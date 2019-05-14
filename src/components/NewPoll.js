import React from 'react';

class NewPoll extends React.Component {
  state = {
    question: '',
    pollOption: '',
    options: []
  }

  handleChange = (e) => {
    const change = {[e.target.name]: e.target.value}
    this.setState(change);
  }

  handlePollOption = () => {
    const { options, option } = this.state;
    const optionsArr = [...options, option ];
    this.setState({options: optionsArr, option: ''})
  }

  handlePollSubmit = async (e) => {
    e.preventDefault();
    console.log("poll submit");

    const { question, options } = this.state

    const poll = {
      question,
      options
    }

    const token = this.props.cookies.cookies.token;

    await fetch("http://localhost:4000/create-poll",{
      method: "POST",
      body: JSON.stringify({poll, token}),
      headers: {'Content-Type': 'application/json'}
    }).then(response => response.json())
    .then(data => {
      console.log(data);
    });
  }

  render() {
    return (
      <form onSubmit={this.handlePollSubmit}>
        <input placeholder="question" name="question" onChange={this.handleChange}/>
        <input placeholder="first option" name="option" onChange={this.handleChange} value={this.state.option} />
        <span onClick={this.handlePollOption}>Add option</span>
        <button>Add poll</button>
      </form>
    )
  }
}

export default NewPoll;

