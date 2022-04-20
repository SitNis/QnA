shared_examples_for 'API Commentable' do
  let(:comment) { comments.first }
  let(:comment_response) { commentable_response }

  it 'returns list of comments' do
    expect(commentable_response.size).to eq 2
  end

  it 'returns all public fields' do
    %w[id body created_at updated_at].each do |attr|
      expect(commentable_response.first[attr]).to eq comment.send(attr).as_json
    end
  end
end
