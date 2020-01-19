require "application_system_test_case"

class WarriorknowledgesTest < ApplicationSystemTestCase
  setup do
    @warriorknowledge = warriorknowledges(:one)
  end

  test "visiting the index" do
    visit warriorknowledges_url
    assert_selector "h1", text: "Warriorknowledges"
  end

  test "creating a Warriorknowledge" do
    visit warriorknowledges_url
    click_on "New Warriorknowledge"

    click_on "Create Warriorknowledge"

    assert_text "Warriorknowledge was successfully created"
    click_on "Back"
  end

  test "updating a Warriorknowledge" do
    visit warriorknowledges_url
    click_on "Edit", match: :first

    click_on "Update Warriorknowledge"

    assert_text "Warriorknowledge was successfully updated"
    click_on "Back"
  end

  test "destroying a Warriorknowledge" do
    visit warriorknowledges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Warriorknowledge was successfully destroyed"
  end
end
