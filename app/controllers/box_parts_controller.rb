class BoxPartsController < ApplicationController
  before_action :set_box_part, only: [:show, :edit, :update, :destroy]

  # GET /box_parts
  # GET /box_parts.json
  def index
    @box_parts = BoxPart.all
  end

  # GET /box_parts/1
  # GET /box_parts/1.json
  def show
  end

  # GET /box_parts/new
  def new
    @box_part = BoxPart.new
  end

  # GET /box_parts/1/edit
  def edit
  end

  # POST /box_parts
  # POST /box_parts.json
  def create
    @box_part = BoxPart.new(box_part_params)

    respond_to do |format|
      if @box_part.save
        format.html { redirect_to @box_part, notice: 'Box part was successfully created.' }
        format.json { render :show, status: :created, location: @box_part }
      else
        format.html { render :new }
        format.json { render json: @box_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /box_parts/1
  # PATCH/PUT /box_parts/1.json
  def update
    respond_to do |format|
      if @box_part.update(box_part_params)
        format.html { redirect_to @box_part, notice: 'Box part was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_part }
      else
        format.html { render :edit }
        format.json { render json: @box_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /box_parts/1
  # DELETE /box_parts/1.json
  def destroy
    @box_part.destroy
    respond_to do |format|
      format.html { redirect_to box_parts_url, notice: 'Box part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box_part
      @box_part = BoxPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_part_params
      params.require(:box_part).permit(:part_num, :prow_id, :user_id)
    end
end
