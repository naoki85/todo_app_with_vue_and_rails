require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  setup do
    @task_not_finished = Task.create!(name: 'Running')
    @task_finished     = Task.create!(name: 'Studying', is_done: true)

    visit root_path
  end

  test 'viewing the index and click "display finished tasks" button' do
    assert_text 'Running'
    assert_no_text 'Studying'

    click_on 'Display finished tasks'
    assert_text 'Running'
    assert_text 'Studying'
  end

  test 'Add a new task' do
    assert_no_text 'Cooking'
    within(:xpath, "//*[@id='app']/div[2]/div/div[1]") do
      fill_in 'new-task-form', with: 'Cooking'
      click_on 'add'
    end
    assert_text 'Cooking'
  end

  test 'done a finished task' do
    assert_text 'Running'
    within(:xpath, '//*[@id="app"]/div[2]/div/div[2]/ul') do
      find('label', text: 'Running').click
    end
    assert_no_text 'Running'

    click_on 'Display finished tasks'
    assert_text 'Running'

    task = Task.find_by(name: 'Running')
    assert_equal true, task.is_done
    within(:xpath, '//*[@id="finished-tasks"]/ul') do
      has_checked_field?('Running')
    end
  end
end