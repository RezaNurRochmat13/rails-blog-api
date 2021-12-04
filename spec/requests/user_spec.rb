require 'rails_helper'

RSpec.describe 'User Request' do
  let(:user) { create_list(:user, 10) }
  
  describe 'GET All User' do
    context 'before publication' do
      it 'cannot have comments' do
        p user
      end
    end
  end
end
  