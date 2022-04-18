shared_examples_for 'API Fileable' do
  let(:files_response) { fileable_response }

  it 'returns list of files' do
    expect(files_response.size).to eq 2
  end
end
