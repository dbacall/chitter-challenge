require_relative '../web_helper.rb'

feature 'message feed' do

  scenario 'can see chitter feed page' do

    visit '/'
    expect(page).to have_content 'Chitter Feed'

  end

  scenario 'can see all messages that have been posted' do
    create_account
    sign_in
    fill_in 'message', with: 'Hello world'
    click_on 'Post'
    fill_in 'message', with: 'Message number two'
    click_on 'Post'
    expect(page).to have_content 'Hello world'
    expect(page).to have_content 'Message number two'
  end

end
