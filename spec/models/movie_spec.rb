require 'rails_helper'

RSpec.describe Movie do
  describe "validations" do
    it {should validate_presence_of :title }
    it {should validate_presence_of :creation_year }
    it {should validate_presence_of :genre }
  end
  describe 'relationships' do
    it { should belong_to :studio }
    it { should have_many(:actors).through :actors_movies }
  end
end