require 'spec_helper'

feature "User submits a new post" do

  scenario "when browsing the homepage" do
    expect(Post.count).to eq(0)
    visit '/'
    submit_post('The Interview is so funny.')
    expect(Post.count).to eq(1)
    post = Post.first
    expect(post.message).to eq('The Interview is so funny.')
  end

  def submit_post(message)
    within('.new-post') do
      fill_in 'message', :with => message
      click_button 'Post'
    end
  end
end
