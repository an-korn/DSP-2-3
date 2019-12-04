require 'test_helper'

class DspControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dsp_new_url
    assert_response :success
  end

  test "should get create" do
    get dsp_create_url
    assert_response :success
  end

  test "should get show" do
    get dsp_show_url
    assert_response :success
  end

end
