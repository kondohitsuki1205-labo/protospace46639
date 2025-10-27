class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

   def index
    @prototypes = Prototype.all
   end

   def new
    @prototype = Prototype.new
   end
  

   def create
    @prototype = Prototype.new(prototype_params)
     if @prototype.save
      redirect_to root_path
     else
      render :new, status: :unprocessable_entity
     end
   end

   def show
    @comment  = Comment.new
    @comments = @prototype.comments.order(:created_at)
   end

   def edit
    @prototype = Prototype.find(params[:id])
   end

   def update
    @prototype = Prototype.find(params[:id])
     if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
     else
      render :edit, status: :unprocessable_entity
     end
    end

   def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
   end

   private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless current_user == @prototype.user
  end
end