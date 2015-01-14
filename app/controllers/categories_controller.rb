class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  before_action :custom_authentication
  def custom_authentication
    if (user_signed_in?)
      
    else
      redirect_to new_user_session_path
    end
  end

  def index

    @categories=Category.all

  end

  def show
    redirect_to category_products_path(@category)
    # @products=Category.find(params[:id]).products
  end
  def new
    @category=Category.new()
    2.times {@category.products.build}
  end

  def create
    # binding.pry
    @category=Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit

  end
  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:notice]='Category was successfully updated.'
        format.html { redirect_to categories_url}
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      flash.now[:notice]='Category was successfully destroyed.'
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
private
  def category_params
    # params.require(:category).permit(:name)
    params.require(:category).permit(:name, products_attributes:
    [:name, :quality, :quantity, :id])
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
