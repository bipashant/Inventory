class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @category=Category.find(params[:category_id])
    @products=@category.products
  end

  def new
    @category=Category.find(params[:category_id])
    @product=@category.products.new
  end

  def edit
    @category=Category.find(params[:category_id])
    @product=Product.find(params[:id])
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        flash[:notice]='Product was successfully updated.'
        format.html { redirect_to category_product_url }
        format.json { render :show, status: :ok, location: @product }
      else
        flash[:notice]='Product update was not successful.'
        format.html { render :edit }
        format.json { render json: @product.errors, sedit_product_pathtatus: :unprocessable_entity }
      end
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.create(product_params)
    respond_to do |format|
      if @product.save
        flash[:notice]='Product was successfully created.'
        format.html { redirect_to  [@product.category, @product]}
        format.json { render :show, status: :created, location: @product }
      else
        flash[:notice]='Product creation was not successful'
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def destroy
    @product_id = @product.id
    respond_to do |format|
    if (@product.destroy)
      format.js
    end
    end
  end

  private
  def product_params
    params.require(:product).permit(:name,:category_id)
  end
  def set_product
    @product=Product.find(params[:id])
    @category=Category.find(params[:category_id])
    # begin
    #
    # rescue
    #   respond_to do |format|
    #
    #     format.js
    #     # {render json:{status:'failure', message:'failed to deleted product'}}
    #   end
    # end

  end

end
