class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.nueva_busqueda(params[:ticker])
      stock.save
    end

    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} se creo exitosamente"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} fue removida exitosamente del portfolio "
    redirect_to my_portfolio_path
  end

end
