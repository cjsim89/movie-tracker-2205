require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe "validations" do
    it {should validate_presence_of :name }
    it {should validate_presence_of :age }
  end
  describe 'relationships' do
    it { should have_many :movies }
  end
end