class ConsumptionsController < ApplicationController
  before_action :set_consumption, only: [:show, :edit, :update, :destroy]

  # GET /consumptions
  # GET /consumptions.json
  def index
    @consumptions = Consumption.all
  end

  
  helper_method :consumption_table
  helper_attr :all_times
  attr_accessor :all_times
  
  def consumption_table

    @prow_arr = Array.new
    @all_times = Array.new
    @separator = 0;

    current_user.prescriptions.each do |upres|
      upres.prows.each do |uprow|
        @prow_arr[@prow_arr.size] = uprow
      end
    end

    @prow_arr.each do |pp|
      @all_times[@separator] = [pp.start_time, pp.id, 0]
      
      for i in 1..pp.qty-1 do
        @all_times[@separator+i] = [(@all_times[@separator+i-1][0] + pp.period.to_i.hours), pp.id, 0]
      end

      @separator = i
    end

    @all_times = @all_times.sort
  end

  # GET /consumptions/1
  # GET /consumptions/1.json
  def show
  end

  # GET /consumptions/new
  def new
    @consumption = Consumption.new
  end

  # GET /consumptions/1/edit
  def edit
  end

  def remote_consumption 
    @consumption = Consumption.new
    @BoxPart = BoxPart.find(params[:bp])
    
    @consumption.take_status = params[:ts]
    @consumption.prow_id = @BoxPart.prow_id
    @consumption.save
    render :layout => false
  end

  helper_method :consume
  def consume(i,prow_id, time)
    @prow = Prow.find_by_id(prow_id)
    @interval = 30.minutes
    @tik = 0
    if @prow.consumptions != nil
        @prow.consumptions.each do |pc|
          if time.utc - @interval <= pc.created_at and pc.created_at <= time.utc and pc.take_status.to_i == 1
            @tik = 1 
            @all_times[i][2] = 1
            break
         
          elsif pc.created_at - @interval <= time.utc and time.utc <= pc.created_at and pc.take_status.to_i == 1
            @tik = 1 
            @all_times[i][2] = 1
            break
          
          else
            @tik = 0
          end
           
        end
    else
      @tik = 0
    end
    return @tik
  end

  helper_method :if_noti
  def if_noti()

    for j in 0..@all_times.size-1 
      if @all_times[j][0].time + 30.minutes < Time.now.utc and @all_times[j][2] == 0
        SendMail.sample_email(current_user, find_drug_name(@all_times[j][1]), @all_times[j][0] ).deliver
      end
    end
  end






  helper_method :find_drug_name
  def find_drug_name(prid)
    @prow = Prow.find_by_id(prid)
    @drug = Drug.find_by_id(@prow.drug_id)
    return @drug.name
  end

  # POST /consumptions
  # POST /consumptions.json
  def create
    @consumption = Consumption.new(consumption_params)

    respond_to do |format|
      if @consumption.save
        format.html { redirect_to @consumption, notice: 'Consumption was successfully created.' }
        format.json { render :show, status: :created, location: @consumption }
      else
        format.html { render :new }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumptions/1
  # PATCH/PUT /consumptions/1.json
  def update
    respond_to do |format|
      if @consumption.update(consumption_params)
        format.html { redirect_to @consumption, notice: 'Consumption was successfully updated.' }
        format.json { render :show, status: :ok, location: @consumption }
      else
        format.html { render :edit }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumptions/1
  # DELETE /consumptions/1.json
  def destroy
    @consumption.destroy
    respond_to do |format|
      format.html { redirect_to consumptions_url, notice: 'Consumption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumption
      @consumption = Consumption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumption_params
      params.require(:consumption).permit(:start_time, :take_status, :prow_id)
    end
end