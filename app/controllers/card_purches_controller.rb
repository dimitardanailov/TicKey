class CardPurchesController < ApplicationController
  include CardPurchesHelper
  before_action :set_card_purch, only: [:show, :edit, :update, :destroy]
  before_action :selectbox_collection_items, only: [:new, :create, :edit, :update]

  # http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  protect_from_forgery with: :null_session

  # GET /card_purches
  # GET /card_purches.json
  def index
    @card_purches = CardPurch.all
  end

  # GET /card_purches/1
  # GET /card_purches/1.json
  def show
  end

  # GET /card_purches/new
  def new
    @card_purch = CardPurch.new
  end

  # GET /card_purches/1/edit
  def edit
  end

  # POST /card_purches
  # POST /card_purches.json
  def create
    @card_purch = CardPurch.new(card_purch_params)

    respond_to do |format|
      if @card_purch.save
        format.html { redirect_to @card_purch, notice: 'Card purch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @card_purch }
      else
        format.html { render action: 'new' }
        format.json { render json: @card_purch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_purches/1
  # PATCH/PUT /card_purches/1.json
  def update
    respond_to do |format|
      if @card_purch.update(card_purch_params)
        format.html { redirect_to @card_purch, notice: 'Card purch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card_purch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_purches/1
  # DELETE /card_purches/1.json
  def destroy
    @card_purch.destroy
    respond_to do |format|
      format.html { redirect_to card_purches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_purch
      @card_purch = CardPurch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_purch_params
      params.require(:card_purch).permit(:user_id, :transport_card_type_id, :line_id, :expire_date)
    end

    def selectbox_collection_items
      @transport_card_type_options = TransportCardType.all.map{ |c| [ c.name, c.id ] }
      @line_options = Line.all.map{ |l| [l.name, l.id] }
      @user_options = User.all.map{ |u| [u.id, u.id] }
    end
end
