shared_examples "a decorator" do

  it {should respond_to(:pretty_created_at)}
  it {should respond_to(:pretty_updated_at)}
  it {should respond_to(:pretty_published_at)}
  it {should respond_to(:created_by_name)}
  it {should respond_to(:updated_by_name)}
  it {should respond_to(:published_by_name)}

  it 'must properly test created_by_name'
  it 'must properly test updated_by_name'
  it 'must properly test published_by_name'
  it 'must properly test pretty_created_at'
  it 'must properly test pretty_updated_at'
  it 'must properly test pretty_published_at'

end