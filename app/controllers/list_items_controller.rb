class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:switch_done, :update, :destroy]

  # GET /list_items (or GET /)
  def index
    @list_items = ListItem.all
    @new_item = ListItem.new
  end

  # POST /list_items
  def create
    @list_item = ListItem.new(list_item_params)
    if @list_item.save
      respond_to do |format|
        format.js
      end
    else
      render nothing: true
    end
  end

  # PATCH /switch_done
  def switch_done
    @list_item.switch_done
    @list_item.save
    respond_to do |format|
      format.js
    end
  end

  # PATCH /list_items/:id
  def update
    @list_item.update(list_item_params)
    render nothing: true
  end

  # DELETE /list_items/:id
  def destroy
    @list_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_list_item
    @list_item = ListItem.find(params[:id])
  rescue => e
    logger.error("ERROR: #{e.message}")
    render nothing: true
  end

  def list_item_params
    params.require(:list_item).permit(:text)
  end
end
