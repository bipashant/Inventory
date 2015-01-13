class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @category=Category.find(params[:category_id])
    @products=@category.products


  end
  def new
    @category=Category.find(params[:category_id])
    @product=Product.new
  end

  def edit
    @category=Category.find(params[:category_id])
    @product=Product.find(params[:id])
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to category_product_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, sedit_product_pathtatus: :unprocessable_entity }
      end
    end
  end

  def create


    @product=Product.new(name:product_params[:name],category_id:product_params[:category_id])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end



  def show

  end

  private
  def product_params
    params.require(:product).permit(:name,:category_id)
  end
def set_product
  @product=Product.find(params[:id])
end

end
