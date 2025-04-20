class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
   @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create 
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path  # 保存成功 → トップページ
    else
      render :new    # 保存失敗 → new.html.erb を表示
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update 
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)  # 更新成功 → 詳細ページへ
    else
      render :edit  # 更新失敗 → 編集ページを再表示
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def redirect_unless_logged_in
  unless user_signed_in?
    redirect_to action: :index
  end
end
end
