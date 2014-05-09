class TransportCardTypesController < ApplicationController
  before_action :set_transport_card_type, only: [:show, :edit, :update, :destroy]

  # GET /transport_card_types
  # GET /transport_card_types.json
  def index
    @transport_card_types = TransportCardType.all
  end

  # GET /transport_card_types/1
  # GET /transport_card_types/1.json
  def show
  end

  # GET /transport_card_types/new
  def new
    @transport_card_type = TransportCardType.new
  end

  # GET /transport_card_types/1/edit
  def edit
  end

  # POST /transport_card_types
  # POST /transport_card_types.json
  def create
    @transport_card_type = TransportCardType.new(transport_card_type_params)

    respond_to do |format|
      if @transport_card_type.save
        format.html { redirect_to @transport_card_type, notice: 'Transport card type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transport_card_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @transport_card_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_card_types/1
  # PATCH/PUT /transport_card_types/1.json
  def update
    respond_to do |format|
      if @transport_card_type.update(transport_card_type_params)
        format.html { redirect_to @transport_card_type, notice: 'Transport card type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transport_card_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_card_types/1
  # DELETE /transport_card_types/1.json
  def destroy
    @transport_card_type.destroy
    respond_to do |format|
      format.html { redirect_to transport_card_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_card_type
      @transport_card_type = TransportCardType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_card_type_params
      params.require(:transport_card_type).permit(:name)
    end
end
