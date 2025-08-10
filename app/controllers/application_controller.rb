# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cookies

  def set_cookies
    cookies.delete(Rails.application.config.session_options[:key])
    @cookie_keys = cookies.to_h.keys
    Subtype.each do |subtype|
      @tla = subtype.tla
      delete_add_or_unchanged
    end
  end

  def home = (@title = 'Introduction')

  def attitudes = (@title = '4 Attitudes')

  def realms = (@title = '4 Realms')

  private

  def delete_add_or_unchanged
    return unless params.key? @tla

    delete || add || Rails.logger.debug { "#{@tla} cookie unchanged: #{params[@tla]}" }
    @cookie_keys.delete(@tla)
  end

  def delete
    return unless cookies[@tla].present? && params[@tla].blank?

    Rails.logger.debug { "#{@tla} cookie deleted: #{params[@tla]}" }
    cookies.delete(@tla)
  end

  def add
    return unless params[@tla] != cookies[@tla]

    Rails.logger.debug { "#{@tla} cookie added: #{params[@tla]}" }
    @added = @tla
    cookies[@tla] = params[@tla]
  end
end
