class UsersController < ApplicationController
  
  # our index method should return a collection of all users
  def index

    # Gets all the users (default order is by creations)
    #@users = User.all
    
    # Gets all the users ordered by username (defaults to ASC)
    @users = User.order(:username).all
    
  end

  # our show method should return 1 user...
  # in this example we are using the begin/rescue block to handle any nil @user instances
  def show
    begin 
      @user = User.find params[:id]
    rescue
      redirect_to users_path, :alert => "No user by that id."
    end
  end

  #
  def edit
    begin 
      @user = User.find params[:id]
    rescue
      redirect_to users_path, :alert => "No user by that id."
    end
  end

  def update
    begin
      @user = User.find_by_id(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to @user, notice: "User was saved successfully!"
      else
        render :edit
      end

    rescue
      render :edit
    end
  end

  # new - method almost ready (let's add in the other form fields to complete)
  def new
    @user = User.new
  end

  def destroy
    # begin 
    #   @user = User.find params[:id]
    #   @user.destroy!
    #   redirect_to users_path, notice: "User was destroyed."
    # rescue
    #   redirect_to users_path
    # end 
  end

  # create - method ready for our prototype app.
  def create
    @user = User.new(params[:user])

    if @user.valid? then
      if @user.save!
          redirect_to @user, notice: "User was saved successfully!"
        else
          render :new
        end
    else
       render :new
    end
  end
end
