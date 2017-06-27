require 'test_helper'

class RentingPhasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @renting_phase = renting_phases(:one)
  end

  test "should get index" do
    get renting_phases_url
    assert_response :success
  end

  test "should get new" do
    get new_renting_phase_url
    assert_response :success
  end

  test "should create renting_phase" do
    assert_difference('RentingPhase.count') do
      post renting_phases_url, params: { renting_phase: { contract_id: @renting_phase.contract_id, cycles: @renting_phase.cycles, end_date: @renting_phase.end_date, price: @renting_phase.price, start_date: @renting_phase.start_date } }
    end

    assert_redirected_to renting_phase_url(RentingPhase.last)
  end

  test "should show renting_phase" do
    get renting_phase_url(@renting_phase)
    assert_response :success
  end

  test "should get edit" do
    get edit_renting_phase_url(@renting_phase)
    assert_response :success
  end

  test "should update renting_phase" do
    patch renting_phase_url(@renting_phase), params: { renting_phase: { contract_id: @renting_phase.contract_id, cycles: @renting_phase.cycles, end_date: @renting_phase.end_date, price: @renting_phase.price, start_date: @renting_phase.start_date } }
    assert_redirected_to renting_phase_url(@renting_phase)
  end

  test "should destroy renting_phase" do
    assert_difference('RentingPhase.count', -1) do
      delete renting_phase_url(@renting_phase)
    end

    assert_redirected_to renting_phases_url
  end
end
