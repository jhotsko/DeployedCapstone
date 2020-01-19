require 'test_helper'

class WarriorknowledgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warriorknowledge = warriorknowledges(:one)
  end

  test "should get index" do
    get warriorknowledges_url
    assert_response :success
  end

  test "should get new" do
    get new_warriorknowledge_url
    assert_response :success
  end

  test "should create warriorknowledge" do
    assert_difference('Warriorknowledge.count') do
      post warriorknowledges_url, params: { warriorknowledge: {  } }
    end

    assert_redirected_to warriorknowledge_url(Warriorknowledge.last)
  end

  test "should show warriorknowledge" do
    get warriorknowledge_url(@warriorknowledge)
    assert_response :success
  end

  test "should get edit" do
    get edit_warriorknowledge_url(@warriorknowledge)
    assert_response :success
  end

  test "should update warriorknowledge" do
    patch warriorknowledge_url(@warriorknowledge), params: { warriorknowledge: {  } }
    assert_redirected_to warriorknowledge_url(@warriorknowledge)
  end

  test "should destroy warriorknowledge" do
    assert_difference('Warriorknowledge.count', -1) do
      delete warriorknowledge_url(@warriorknowledge)
    end

    assert_redirected_to warriorknowledges_url
  end
end
