class ArticlesController < ApplicationController
  def index
    # Articleモデルを経由して、DBのarticlesテーブルの中身を全て@articlesに代入？ってこと？
    # @articles = Article.all
    # ページネーション用インスタンス変数
    @articleList = Article.paginate(page: params[:page], per_page: 5)

    # タグ名をクリックした時、そのタグが付与された記事の一覧ページへ遷移
    if params[:tag_name]
      @articleList = @articleList.tagged_with("#{params[:tag_name]}")
      @tagName = "#{params[:tag_name]}"
    end

    # 記事のランダム表示用
    @randArticleList = Article.order("RANDOM()").limit(4)

    #タグ一覧表示用
    @tagList = Tags.pluck("name")
    # render plain: @tagList.inspect
  end

  def show
    @article = Article.find(params[:id])
    # 前後の記事
    @previousArticle = @article.previous
    @nextArticle = @article.next
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # ▼テスト用_formから渡ってきた値をviewとして表示する
    # render plain: @article.inspect

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :image, :tag_list)
  end
end
