require "test_helper"
require "application_system_test_case"

class RegisterTest < ApplicationSystemTestCase
  test "a user can visit the root URL, click register and create an account" do
    visit(root_url)
    assert_selector("a", text: I18n.t("register"))
  end
end
