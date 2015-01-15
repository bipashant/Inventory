class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :custom_authentication

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
        notice='category_was_successfully_created'
        format.html { redirect_to categories_url, notice: notice }
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
        notice='category_was_successfully_updated'
        flash[:notice]=notice
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
      notice='category_was_successfully_destroyed'
      flash.now[:notice]=notice
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
