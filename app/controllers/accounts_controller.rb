class AccountsController < ApplicationController
  before_action :set_account, only: %i[show]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    def record_not_found
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
end
