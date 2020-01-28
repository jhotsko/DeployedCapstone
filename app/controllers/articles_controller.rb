class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order(date: :desc).page(params[:page]).per_page(15)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @tagList = [['All','All'],['Alpha','Alpha'],['Bravo','Bravo']]
  end

  # GET /articles/1/edit
  def edit
    @tagList = [['All','All'],['Alpha','Alpha'],['Bravo','Bravo']]
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @cadets = Cadet.all
    
    if @article.save

      @cadets.each do |cadet|
        ArticleMailer.with(article: @article, cadet: cadet).new_article_email.deliver_later
      end
      redirect_to @article, success: "New post has been successfully created."
        
    else
      redirect_to '/articles/new', danger: "Post not created."
       
    end
    
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update

    if @article.update(article_params)
      redirect_to @article, success: "Post was successfully updated."
    
    else
      redirect_to edit_article_path(@article), danger: "Post was not updated."
      
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    redirect_to articles_url, info: "Post successfully deleted."
  end
  
  def download_pdf
    send_file "#{Rails.root}/app/assets/docs/Физика.pdf", type: "application/pdf", x_sendfile: true
  end
  
  def download_pdf
    @article = Article.find(params[:article_id])
    redirect_to @article.file.url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:date, :title, :body, :tag, :file)
    end
end
