class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @friends = Friend.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @findingfriends = []
        @users = User.all
        @find_friends = User.find_friends(current_user.id)
        @userfriends = User.friends(current_user.id)
        @pending_friends = User.pending_friends(current_user.id)
        @pending_friends_at_sender = User.pending_friends_at_sender(current_user.id)
        @accepted_friends = User.accepted_friends(current_user.id)
        @accepted_friends_at_sender = User.accepted_friends_at_sender(current_user.id)
        @findingfriends += @accepted_friends.ids 
        @findingfriends += @accepted_friends_at_sender.ids
        @findingfriends += @pending_friends.ids
        @findingfriends += @pending_friends_at_sender.ids
        # binding.pry
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.require(:user).permit(:name, :password)
          params.permit(:name, :password)

    end
end
