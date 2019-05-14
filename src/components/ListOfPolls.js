import React, { useState } from 'react';

const ListOfPolls = (props) => {
  const { polls, handleVoteClick, handleNewAnswer} = props;
  const [answerFormVisible, displayAnswerForm] = useState(false);
  const [newAnswer, addNewAnswer] = useState("")

  const handleDisplayAnswerForm = () => displayAnswerForm(!answerFormVisible);

  const handleChange = (e) => {
    addNewAnswer(e.target.value)
  }

  return (
    <>
    {answerFormVisible ?
            <form onSubmit={(e) => handleNewAnswer(e, newAnswer)}>
              <input value={newAnswer} onChange={handleChange} />
            </form>
        : null }
      {polls.map(poll => {
        return (
          <div><h3>Question: {poll.question}</h3>
          <button onClick={handleDisplayAnswerForm}>Add new option</button>
          {poll.answers.length > 0 ?
              poll.answers.map(answer => {
                return <p onClick={() => handleVoteClick(poll.id, answer.id)}>Answer: {answer.answer_text} vote: {answer.number_of_votes}</p>
              })
          : null}
          </div>
        )
      })}
    </>
  )
}

export default ListOfPolls;
