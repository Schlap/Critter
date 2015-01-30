require 'spec_helper'

feature 'User browses the list of posts' do

  before(:each) {
    Post.create(:message => 'The Interview is so funny.')
  }

  scenario 'when  opening the hompage' do
    visit '/'
    expect(page).to have_content 'The Interview is so funny.'
  end

end
