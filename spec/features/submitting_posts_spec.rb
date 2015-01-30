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

  scenario "with a few tags" do
    visit '/'
    submit_post('The Interview is so funny.',
                ['northkorea', 'jamesfranco'])
    post = Post.first
    expect(post.tags.map(&:text)).to include('northkorea')
    expect(post.tags.map(&:text)).to include('jamesfranco')
  end

  def submit_post(message, tags = [])
    within('.new-post') do
      fill_in 'message', :with => message
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Post'
    end
  end
end
