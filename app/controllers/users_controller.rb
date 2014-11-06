class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
      @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  	@user = User.find_by_id(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
     @user = User.find_by_id(params[:id]) 
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    begin
      #try to save the user given the filled out all the form
      if @user.save!
        redirect_to '/index', :notice => "Account successfully added"
      else
		    redirect_to '/new', :notice => "something went wrong..."        
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(params[:user])
        format.html { redirect_to "/index", notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.find_by_id(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'User was successfully deleted' }
      format.json { head :no_content }
    end
  end
  
end