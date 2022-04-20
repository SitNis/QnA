shared_examples_for 'Votable' do
  it 'can get vote' do
    votable.vote(1, user)

    expect(votable.votes.first).to be_an_instance_of(Vote)
  end

  it 'can cancel vote' do
    votable.vote(1, user)
    votable.cancel_vote(user)

    expect(votable.votes.count).to eq(0)
  end

  it 'can count score' do
    votable.vote(1, user)

    expect(votable.score).to eq(1)
  end
end
