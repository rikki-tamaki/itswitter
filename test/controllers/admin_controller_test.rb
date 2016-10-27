require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "申請一覧が取得できている" do
    get :index
    assert_response :success
    assert assigns(:demands).present?
    assert_equal 4, assigns(:demands).length
  end

  test "申請を承認できる" do
    id = demands(:na_one).id
    put :archive_demand, id: id
    assert Demand.find(id).archive
  end

  test "承認済みの申請は承認できない" do
    id = demands(:a_one).id
    assert_no_difference "Demand.find(id).updated_at" do
      put :archive_demand, id: id
    end
  end
end
