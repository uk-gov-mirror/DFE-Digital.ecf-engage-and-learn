# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :update_account_created

  def show; end

private

  def update_account_created
    unless current_user.account_created
      current_user.update!(account_created: true)
    end
  end
end
