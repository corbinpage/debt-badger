class DebtsController < ApplicationController
  before_action :set_debt, only: [:show, :edit, :update, :destroy, :deactivate]

  # GET /home
  def home
  end

  # GET /support
  def support
  end

  # POST /DEACTIVATE
  def deactivate
    @debt.deactivate
    redirect_to @debt
  end  

  # POST /SEND
  def send
    Debt.send_automated_messages
  end  

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.all
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  def create
    @debt = Debt.start_new(debt_params)

    if @debt.save
      redirect_to @debt, notice: "Your automated text was successfully created."
    else
      flash[:error] = 'Uh Oh, your automated text was NOT created.' 
      render :new
    end
  end

  # # PATCH/PUT /debts/1
  # # PATCH/PUT /debts/1.json
  # def update
  #   respond_to do |format|
  #     if @debt.update(debt_params)
  #       format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @debt }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @debt.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /debts/1
  # # DELETE /debts/1.json
  # def destroy
  #   @debt.destroy
  #   respond_to do |format|
  #     format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:amount, :debtor_name, :creditor_name, :debtor_phone, :creditor_phone, :message)
    end
end
