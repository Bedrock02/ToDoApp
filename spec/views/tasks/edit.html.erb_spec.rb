require 'rails_helper'

RSpec.describe "tasks/edit", :type => :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :body => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_body[name=?]", "task[body]"

      assert_select "input#task_status[name=?]", "task[status]"
    end
  end
end
