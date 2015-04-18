class ProwsController < ApplicationController
  before_action :set_prow, only: [:show, :edit, :update, :destroy]

  # GET /prows
  # GET /prows.json
  def index
    @prows = Prow.all
  end

  # GET /prows/1
  # GET /prows/1.json
  def show
    @drug = @prow.drug
  end

  # GET /prows/new
  def new
    @prow = Prow.new 
    @prow.prescription_id = params[:prescription_id]
  end

  # GET /prows/1/edit
  def edit
  end

  # POST /prows
  # POST /prows.json
  def create
    @prow = Prow.new(prow_params)
    # @prescription =  Prescription.find(params[:prescription])  
    Drug.set_drug(params[:drug_name],params[:drug_description])
    @drug =  Drug.find_by_name(params[:drug_name])  
    @prow.drug_id = @drug.id

    puts "///////////////////////////////////////////////////////////////"
    puts params[:prescription_id]
    
    @prow.prescription_id = params[:prescription_id]
    

    respond_to do |format|
      if @prow.save
        format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
        format.json { render :show, status: :created, location: @prow }
      else
        format.html { render :new }
        format.json { render json: @prow.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /prows/1
  # PATCH/PUT /prows/1.json
  def update
    respond_to do |format|
      if @prow.update(prow_params)
        format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
        format.json { render :show, status: :ok, location: @prow }
      else
        format.html { render :edit }
        format.json { render json: @prow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prows/1
  # DELETE /prows/1.json
  def destroy
    @prow.destroy
    respond_to do |format|
      format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prow
      @prow = Prow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prow_params
      params.require(:prow).permit(:prescription_id, :period, :drug_id , :qty)
    end
end
