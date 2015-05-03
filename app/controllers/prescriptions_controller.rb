class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  # GET /prescriptions
  # GET /prescriptions.json
  def index
    @prescriptions = Prescription.all
    respond_to do |format|
      format.html { render '_index.html.erb' }
      format.js { 'index.js.erb'}
    end
  end

  # GET /prescriptions/1
  # GET /prescriptions/1.json
  def show
    @prow = Prow.new
    respond_to do |format|
      format.html { render '_show.html.erb' }
      format.js { 'show.js.erb'}
    end
  end

  # GET /prescriptions/new
  def new
    @prescription = Prescription.new
    respond_to do |format|
      format.html { render 'new.html.erb' }
      format.js { 'new.js.erb'}
    end
  end

  # GET /prescriptions/1/edit
  def edit
    respond_to do |format|
      format.html { render 'edit.html.erb' }
      format.js { 'edit.js.erb'}
    end
  end

  # POST /prescriptions
  # POST /prescriptions.json
  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.user_id = current_user.id

    respond_to do |format|
      if @prescription.save
        format.html { redirect_to @prescription, notice: 'Prescription was successfully created.' }
        format.json { render :show, status: :created, location: @prescription }
      else
        format.html { render :new }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescription }
      else
        format.html { render :edit }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescription_params
      params.require(:prescription).permit(:user_id, :doctor_name)
    end
end
