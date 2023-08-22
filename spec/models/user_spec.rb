require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Elli', email: 'elli@gmail.com') }

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter must be integer' do
    expect(subject.email).to eql('elli@gmail.com')
  end
end


