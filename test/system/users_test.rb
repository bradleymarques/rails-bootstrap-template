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

  test "a user cannot register an account if the email address is taken" do
    user = FactoryBot.create(:user)
    email = user.email

    visit(root_url)
    register_buttons = page.find_all("a", text: I18n.t("register"))
    assert_equal(2, register_buttons.count)
    register_buttons.first.click

    assert_selector("h1", text: I18n.t("register"))

    fill_in("Email", with: email)
    fill_in("Password", with: "some-strong-password")
    fill_in("Password confirmation", with: "some-strong-password")

    find('input[name="commit"]').click

    assert(has_text?("Email has already been taken"))
  end

  test "a user cannot register an account without specifying a password" do
    visit(root_url)
    register_buttons = page.find_all("a", text: I18n.t("register"))
    assert_equal(2, register_buttons.count)
    register_buttons.first.click

    assert_selector("h1", text: I18n.t("register"))

    fill_in("Email", with: "someone@example.com")

    find('input[name="commit"]').click

    assert(has_text?("Password can't be blank"))
  end

  test "a user cannot register an account without a matching password confirmation" do
    visit(root_url)
    register_buttons = page.find_all("a", text: I18n.t("register"))
    assert_equal(2, register_buttons.count)
    register_buttons.first.click

    assert_selector("h1", text: I18n.t("register"))

    fill_in("Email", with: "someone@example.com")
    fill_in("Password", with: "some-strong-password")
    fill_in("Password confirmation", with: "this is not the same password")

    find('input[name="commit"]').click

    assert(has_text?("Password confirmation doesn't match Password"))
  end

  test "a user can login successfully" do
    user = FactoryBot.create(:user)

    visit(root_url)
    login_buttons = page.find_all("a", text: I18n.t("login"))
    assert_equal(2, login_buttons.count)
    login_buttons.first.click

    assert_selector("h1", text: I18n.t("login"))

    fill_in("Email", with: user.email)
    fill_in("Password", with: "some-strong-password")

    find('input[name="commit"]').click

    assert(has_text?(I18n.t("devise.sessions.signed_in")))
  end

  test "a user cannot login if they have not confirmed their email address" do
    user = FactoryBot.create(:user, :unconfirmed)

    visit(root_url)
    login_buttons = page.find_all("a", text: I18n.t("login"))
    assert_equal(2, login_buttons.count)
    login_buttons.first.click

    assert_selector("h1", text: I18n.t("login"))

    fill_in("Email", with: user.email)
    fill_in("Password", with: "some-strong-password")

    find('input[name="commit"]').click

    assert(has_text?(I18n.t("devise.failure.unconfirmed")))
  end
end
