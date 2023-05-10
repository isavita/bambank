class AccountsController < ApplicationController
  before_action :set_account, only: %i[show]

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
end
