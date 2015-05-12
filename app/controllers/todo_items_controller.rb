class TodoItemsController < ApplicationController
  def index
  	@todo_list = TodoList.find(params[:todo_list_id])
  end

  def new
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new(todo_item_params)

  	if @todo_item.save
  		flash[:success] = "Added todo list item."
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = "There was a problem added that todo list item"
  		render action: :new
  	end
  end

  def edit
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "Saved todo list item"
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem saving that todo list item"
      render action: :edit
    end
  end

  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private
  def todo_item_params
  	params[:todo_item].permit(:content)
  end

end
