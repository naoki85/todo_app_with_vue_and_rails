require 'application_system_test_case'

class HomeIndexTest < ApplicationSystemTestCase
  setup do
    Task.create!(name: 'Running')
    Task.create!(name: 'Studying', is_done: true)
  end

  test 'viewing the index, about and contact' do
    visit root_path

    assert_selector '.brand-logo', text: 'Todo Application'
    assert_text 'Running'
    # Display finished tasksを押さないと表示されない
    assert_no_text 'Studying'
    click_on 'About'
    assert_text 'This is a sample of TODO application with Vue.js and Ruby on Rails.'

    click_on 'Contact'
    assert_text 'If you want to contact me, you send mail to below address.'
  end
end