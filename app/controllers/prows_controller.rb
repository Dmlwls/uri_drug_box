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
      @prow.start_time = @prow.start_time + 4.hours + 30.minutes
      format.html { render 'edit.html.erb' }
      format.js { 'edit.js.erb'}
    end
  end

  # POST /prows
  # POST /prows.json
  helper_attr :box_err
  attr_accessor :box_err
  

  def create
    @prow = Prow.new(prow_params)
    
    respond_to do |format|
      @box = BoxPart.find_by_part_num_and_user_id(params[:box],current_user.id) # check it is empty !important
      if @box.prow_id == nil
        @drug1 =  Drug.find_by_name_and_description(params[:drug_name],params[:drug_description])  
        if @drug1 == nil
          Drug.add_drug(params[:drug_name],params[:drug_description])
        end
        @drug =  Drug.find_by_name_and_description(params[:drug_name],params[:drug_description])  
        
        @prow.drug_id = @drug.id
        @prow.period_type = params[:prow][:period_type]
        @prow.consumed_qty = @prow.qty
        
        # @prow.start_time = @prow.start_time.in_time_zone("Iran");
        # zone = ActiveSupport::TimeZone.new("Iran")
        # @time = @prow.start_time.in_time_zone(zone)
        # @prow.start_time = @time
        # @prow.start_time = @prow.start_time.in_time_zone(zone).to_time 
        # @prow.start_time = @prow.start_time.change(:offset => "+0430")
        @interval = 4.hours + 30.minutes
        @prow.start_time = @prow.start_time - @interval
        convert_to_hour
        

        if @prow.save
          @box.prow_id = @prow.id
          @box.save


          
          @sth =  Consumption.if_noti(current_user, @prow.id)
          @prow.pjob_id = @sth.id
          @prow.save
          
          @box_err = nil  

          format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
          format.json { render :show, status: :created, location: @prow }
        else
          format.html { render :new }
          format.json { render json: @prow.errors, status: :unprocessable_entity }
        end
      else
          @box_err = 'در این خانه دارو وجود دارد!'
          format.html { render :new}
          format.json { render json: @prow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prows/1
  # PATCH/PUT /prows/1.json
  def update
    @ex_qty = @prow.qty
    @ex_consumed_qty = @prow.consumed_qty
    @ex_start_time = @prow.start_time
    @ex_period = @prow.period
    respond_to do |format|
      @box = BoxPart.find_by_part_num_and_user_id(params[:box],current_user.id) # check it is empty !important
      @box1 = BoxPart.find_by_prow_id(@prow.id)
    if (params[:box] != @box1.part_num && @box.prow_id == nil) || params[:box] == @box1.part_num
      if (params[:box] != @box1.part_num && @box.prow_id == nil)
          @box1.prow_id = nil
          @box1.save
          @box.prow_id = @prow.id
          @box.save
        end
          Drug.set_drug(@prow.drug_id,params[:drug_name],params[:drug_description])
          if @prow.update(prow_params)
              @box_err = nil        
              if params[:prow][:"start_time(1i)"].to_i != @ex_start_time.year or params[:prow][:"start_time(2i)"].to_i != @ex_start_time.month or
                params[:prow][:"start_time(3i)"].to_i != @ex_start_time.day or params[:prow][:"start_time(4i)"].to_i != @ex_start_time.hour or
                params[:prow][:"start_time(5i)"].to_i != @ex_start_time.min

                @interval = 4.hours + 30.minutes
                @st = @prow.start_time - @interval
                @period = convert_to_hour
                Prow.update(@prow.id, :start_time => @st, :period => @period)
              end

              if params[:prow][:qty].to_i != @ex_qty
                @prow.consumed_qty = params[:prow][:qty].to_i
                @prow.save
              
              end
         
              #################################karaye delayed job##################################
              if params[:prow][:period] != @ex_period or params[:prow][:qty].to_i != @ex_qty
                delete_from_delayed_job(@ex_consumed_qty,@prow.pjob_id)
                @sth = Consumption.if_noti(current_user, @prow.id)
                @prow.pjob_id = @sth.id
                @prow.save
              end

              @ex_start_time = @ex_start_time + 4.hour + 30.minutes
              if params[:prow][:"start_time(1i)"].to_i != @ex_start_time.year or params[:prow][:"start_time(2i)"].to_i != @ex_start_time.month or
                params[:prow][:"start_time(3i)"].to_i != @ex_start_time.day or params[:prow][:"start_time(4i)"].to_i != @ex_start_time.hour or
                params[:prow][:"start_time(5i)"].to_i != @ex_start_time.min

                delete_from_delayed_job(@ex_consumed_qty,@prow.pjob_id)
                @sth = Consumption.if_noti(current_user, @prow.id)
                @prow.pjob_id = @sth.id
                @prow.save
              end
              
            #################################karaye delayed job tamoom###########################
            format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
            format.json { render :show, status: :ok, location: @prow }
          else
            format.html { render :edit }
            format.json { render json: @prow.errors, status: :unprocessable_entity }
          end
      else
          @box_err = 'در این خانه دارو وجود دارد!'
          format.html { render :new}
          format.json { render json: @prow.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_from_delayed_job(qty,pjob_id)
   
    for j in 0..qty-1
      if Delayed::Job.find_by_id(pjob_id+j) != nil
        Delayed::Job.find(pjob_id+j).destroy
      end
    end    
     
  end




  # DELETE /prows/1
  # DELETE /prows/1.json
  def destroy
    @box1 = BoxPart.find_by_prow_id(@prow.id)
    @box1.prow_id = nil
    @box1.save

    #destroy drug of this prow
    @prow.drug.destroy
    @prow.destroy

    delete_from_delayed_job(@prow.qty,@prow.pjob_id)

    respond_to do |format|
      format.html { redirect_to prescription_path(:id => @prow.prescription_id) }
      # format.html { redirect_to prows_path }
      format.json { head :no_content }
    end
  end

def is_near
    @BoxPart = BoxPart.find_by_part_num_and_user_id(params[:bp],19)
    @prow = Prow.find_by_id(@BoxPart.prow_id)
    @time_arr = Hash.new
    @time_arr[1] = @prow.start_time
    for i in 2..(24/@prow.period.to_i)-1 do
      @time_arr[i] = @prow.start_time + i*@prow.period.to_i.hours
    end

    @interval = 15.minutes
    @time_arr.each do |t|
      tt = Time.parse(t[1].to_s)
 
      next if Time.now.utc >= tt
      if Consumption.consume(@prow.id, tt) == 1
        @notice = false
        break 
      elsif tt-@interval < Time.now.utc and Time.now.utc < tt
        @notice = true
        break
      else
        @notice = false
      end
      
    end

    render :layout=>false
  end

  def convert_to_hour
    if @prow.period_type == "روز"
      @period = @prow.period.to_i * 24
      @prow.period = @prow.period.to_i * 24
    elsif @prow.period_type == "هفته"
      @period = @prow.period.to_i * 24 * 7
      @prow.period = @prow.period.to_i * 24 * 7
    elsif @prow.period_type == "ساعت"
      @period = @prow.period.to_i
    end
    return @period
  end

  helper_method :find_drug
  helper_attr :drug_desc
  attr_accessor :drug_desc
  helper_attr :drug_nm
  attr_accessor :drug_nm

  def find_drug(drug_id)
    @drug = Drug.find_by_id(drug_id)
    @drug_nm = @drug.name
    if @drug.description == nil
        @drug_desc = nil
    else
        @drug_desc = @drug.description
    end
  end

  helper_method :find_box_part
  def find_box_part
    @bp = BoxPart.find_by_prow_id(@prow.id)
    return @bp
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prow
      @prow = Prow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prow_params
      params.require(:prow).permit(:prescription_id, :period, :start_time, :drug_id , :qty, :period_type, :pjob_id,:consumed_qty)
    end
end
