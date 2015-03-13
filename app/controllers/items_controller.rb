class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:create, :new, :destroy]

  # GET /items
  # GET /items.json
  # GET /items.ics
  def index
    @items = Item.recent
    respond_to do |format|
      format.html
      format.json
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.append_custom_property('X-WR-CALNAME', "amzn-ics")
        @items.each do |item|
          calendar.add_event(item.to_ics(request.host))
        end
        calendar.publish
        render text: calendar.to_ical
      end
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.from_url(item_params[:url])
    @item.user = current_user

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    return render status: 403 if @item.user != current_user
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:url)
    end

    def validate_user
      return redirect_to :root if current_user.nil?
    end
end
