class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :custom_authentication
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
        notice='product_was_successfully_updated'
        flash.now[:notice]=notice
        format.html { redirect_to category_product_url }
        format.json { render :show, status: :ok, location: @product }
      else
        notice = 'product_update_unsuccessful'
        flash.now[:notice]=notice
        format.html { render :edit }
        format.json { render json: @product.errors, sedit_product_pathtatus: :unprocessable_entity }
      end
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.create(product_params)
    UserMailer.send_email(@product.id).deliver
    respond_to do |format|
      if @product.save

        notice='product_was_successfully_created'
        flash.now[:notice]=notice
        format.html { redirect_to  [@product.category, @product]}
        format.json { render :show, status: :created, location: @product }
      else
        notice = 'product_creation_unsuccessful'
        flash[:notice]=notice
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
