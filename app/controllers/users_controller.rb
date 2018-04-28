class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :password]

  def index
    @users = User.all
    respond_to do |format|
      format.html { render "index" }
      format.json { render :json => @users.to_json( :include => [:parents, :kinsfolk] ) }
    end
  end

  def show
    respond_to do |format|
      format.html { render "show" }
      format.json { render :json => @user.to_json( :include => [:parents, :kinsfolk] ) }
    end
  end

  def new
    @user = User.new
  end

  def edit
  end


  def add_parent
    id = params[:id].to_i
    parent = User.find_by_id(id)
    current_user.parents << parent
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :sex, :birthdate, :address, :phone_number, :role, :sibling,:kinsfolk_id,  parent_ids: [])
    end
end
