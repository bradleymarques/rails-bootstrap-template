require "test_helper"
require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "a user can visit the root URL and see the app's name" do
    visit(root_url)
    assert_selector("h1", text: I18n.t("app_name"))
  end
end
