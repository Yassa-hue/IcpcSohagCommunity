require "application_system_test_case"

class WeeksTest < ApplicationSystemTestCase
  setup do
    @week = weeks(:one)
  end

  test "visiting the index" do
    visit weeks_url
    assert_selector "h1", text: "Weeks"
  end

  test "should create week" do
    visit weeks_url
    click_on "New week"

    fill_in "Materials", with: @week.materials
    fill_in "Title", with: @week.title
    fill_in "User", with: @week.user_id
    click_on "Create Week"

    assert_text "Week was successfully created"
    click_on "Back"
  end

  test "should update Week" do
    visit week_url(@week)
    click_on "Edit this week", match: :first

    fill_in "Materials", with: @week.materials
    fill_in "Title", with: @week.title
    fill_in "User", with: @week.user_id
    click_on "Update Week"

    assert_text "Week was successfully updated"
    click_on "Back"
  end

  test "should destroy Week" do
    visit week_url(@week)
    click_on "Destroy this week", match: :first

    assert_text "Week was successfully destroyed"
  end
end
