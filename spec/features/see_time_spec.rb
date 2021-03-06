require_relative '../web_helper.rb'

feature 'time' do

  scenario 'peeps show the time at which they were posted' do
    create_account
    sign_in
    fill_in 'message', with: 'Hello world'
    click_on 'Post'
    expect(page).to have_content "#{Time.now.strftime("%k:%M on %d %B %Y")}"
  end

end
