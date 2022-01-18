class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.nueva_busqueda(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "simbolo no válido"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "ingerse algun simbolo"
        format.js { render partial: 'users/result' }
      end
    end
  end

end
