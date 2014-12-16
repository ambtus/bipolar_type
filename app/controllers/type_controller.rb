class TypeController < ApplicationController
  def show
    if params[:id].blank?
      @next = "behave"
      render :start
    elsif %w{behave sf st nf nt}.include?(params[:id])
      @next = case params[:id]
              when "behave"
                "sf"
              when "sf"
                "st"
              when "st"
                "nf"
              when "nf"
                "nt"
              when "nt"
                "bipolar"
              end
      I18n.with_locale(params[:id]) { render "behave" }
    elsif %w{st sf nt nf}.permutation(4).map(&:join).include?(params[:id])
      @subtypes=params[:id].scan(/../)
      render "type"
    else
      render params[:id]
    end
  end

end
