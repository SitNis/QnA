shared_examples_for 'API Linkable' do
  let(:link) { links.first }
  let(:link_response) { linkable_response }

  it 'returns list of links' do
    expect(link_response.size).to eq 2
  end

  it 'returns all public fields' do
    %w[id name url created_at updated_at].each do |attr|
      expect(link_response.first[attr]).to eq link.send(attr).as_json
    end
  end
end
