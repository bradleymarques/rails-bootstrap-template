require "test_helper"
require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "a user can visit the root URL, click register and create an account" do
    visit(root_url)
    register_buttons = page.find_all("a", text: I18n.t("register"))
    assert_equal(2, register_buttons.count)
    register_buttons.first.click

    assert_selector("h1", text: I18n.t("register"))

    fill_in("Email", with: "someone@example.com")
    fill_in("Password", with: "some-strong-password")
    fill_in("Password confirmation", with: "some-strong-password")

    find('input[name="commit"]').click

    assert(has_text?(I18n.t("devise.registrations.signed_up_but_unconfirmed")))
  end
end
