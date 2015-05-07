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
    respond_to do |format|
      format.html { render 'new.html.erb' }
      format.js { 'new.js.erb'}
    end
  end

  # GET /prows/1/edit
  def edit
    respond_to do |format|
      format.html { render 'edit.html.erb' }
      format.js { 'edit.js.erb'}
    end
  end

  # POST /prows
  # POST /prows.json
  
    
  def create
    @prow = Prow.new(prow_params)
    # @prescription =  Prescription.find(params[:prescription])  
    Drug.add_drug(params[:drug_name],params[:drug_description])
    @drug =  Drug.find_by_name(params[:drug_name])  
    @prow.drug_id = @drug.id
    @prow.period_type = params[:prow][:period_type]
    @box = BoxPart.find_by_part_num(params[:box]) # check it is empty !important
    # @prow.start_time = @prow.start_time.in_time_zone("Iran");
    # debugger
    # zone = ActiveSupport::TimeZone.new("Iran")
    # @time = @prow.start_time.in_time_zone(zone)
    # @prow.start_time = @time
    # @prow.start_time = @prow.start_time.in_time_zone(zone).to_time 
    # @prow.start_time = @prow.start_time.change(:offset => "+0430")
    @interval = 4.hours + 30.minutes
    @prow.start_time = @prow.start_time - @interval
    debugger

    respond_to do |format|
      if @prow.save
        @box.prow_id = @prow.id
        @box.save
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
        Drug.set_drug(@prow.drug.id,params[:drug_name],params[:drug_description])
        @box = BoxPart.find_by_part_num(params[:box]);  # check it is empty !important
        @box.prow_id = @prow.id
        @box.save
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
      # format.html { redirect_to prows_path }
      format.json { head :no_content }
    end
  end

  def is_near
    @prow = Prow.find(params[:id])
    @time_arr = Hash.new
    for i in 1..(24/@prow.period.to_i)-1 do
      @time_arr[i] = @prow.start_time + i*@prow.period.to_i.hours
    end

    @interval = 1.hour #30.minutes
    @time_arr.each do |t|
      tt = Time.parse(t[1].to_s)
      # byebug
      next if Time.now.utc > tt
      if tt-@interval < Time.now.utc and Time.now.utc < tt
        @notice = true
        break
      else
        @notice = false
      end
    end

    render :layout=>false
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prow
      @prow = Prow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prow_params
      params.require(:prow).permit(:prescription_id, :period, :start_time, :drug_id , :qty, :perid_type)
    end
end
