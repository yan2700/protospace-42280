class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      # 保存成功 → コメントしたプロトタイプの詳細ページにリダイレクト
      redirect_to prototype_path(@comment.prototype)
    else
      # 保存失敗 → プロトタイプ詳細ページに戻す（コメント一覧など再描画用に変数も準備）
      @prototype = @comment.prototype
      @comments = @prototype.comments.includes(:user)
      render 'prototypes/show'
    end
  end
 private

 def comment_params
   params.require(:comment).permit(:content).merge(
     user_id: current_user.id,
     prototype_id: params[:prototype_id]
   )
 end
end
