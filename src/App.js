import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import { withCookies, Cookies } from 'react-cookie';
import propTypes from 'prop-types';
import { instanceOf } from 'prop-types';
import NewPoll from './components/NewPoll';
import ListOfPolls from './components/ListOfPolls';

class App extends Component {
constructor(props) {
  super(props)
  this.state = {
    email: "",
    password: "",
    polls: []
  }
}

static propTypes = {
  cookies: instanceOf(Cookies).isRequired
};

handleNewAnswer = (e, answer) => {
  e.preventDefault();
  console.log(answer)
}

handleChange = (e) => {
  const change = {[e.target.name]: e.target.value}
  this.setState(change);
}

handleLogin = async (e) => {
  const { email, password } = this.state;
  const { cookies } = this.props;
  e.preventDefault();
  await fetch("http://localhost:4000/login",{
    method: "POST",
    body: JSON.stringify({email, password}),
    headers: {'Content-Type': 'application/json'}
  }).then(response => response.json())
  .then(data => {
    console.log(data)
    const { token } = data;
    cookies.set('token', token, { path: '/' });
  });
}

handleSignUp = async (e) => {
  const { email, password } = this.state;
  e.preventDefault();
  await fetch("http://localhost:4000/create-user",{
    method: "POST",
    body: JSON.stringify({email, password}),
    headers: {'Content-Type': 'application/json'}
  }).then(response => response.json())
  .then(data => console.log(data));
}

getListOfPolls = async () => {
  const resp = await fetch("http://localhost:4000/polls",{
    method: "GET",
    headers: {'Content-Type': 'application/json'}
  });

  const jsonPolls = await resp.json();
  const polls = JSON.parse(jsonPolls.polls)
  console.log(polls)
  this.setState({polls: polls})
}

handleVoteClick = async (pollId, answerId) => {
  await fetch("http://localhost:4000/vote",{
    method: "POST",
    body: JSON.stringify({pollId, answerId}),
    headers: {'Content-Type': 'application/json'}
  }).then(response => response.json())
  .then(data => this.getListOfPolls());
}

componentDidMount() {
  this.getListOfPolls();
}

  render() {
    const { polls } = this.state;
    return (
      <div className="App">
          <ListOfPolls polls={polls} handleVoteClick={this.handleVoteClick} handleNewAnswer={this.handleNewAnswer} />
          <form onSubmit={this.handleLogin}>
            <input placeholder="email" onChange={this.handleChange} name="email"/>
            <input placeholder="password" name="password" onChange={this.handleChange}/>
            <button>Login!</button>
          </form>
          <form onSubmit={this.handleSignUp}>
            <input placeholder="email" name="email" onChange={this.handleChange} />
            <input type="password" placeholder="password" name="password" onChange={this.handleChange} />
            <button>Sign up</button>
          </form>
          <NewPoll {...this.props} />
      </div>
    );
  }
}

export default withCookies(App);
