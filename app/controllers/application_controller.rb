# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cookies

  def set_cookies
    had_any = false
    @cookie_keys = cookies.to_h.keys
    Subtype.each do |subtype|
      @tla = subtype.tla
      had_any = true if delete_add_or_unchanged
    end
    return unless had_any

    @cookie_keys.each { |tla| cookies.delete(tla) }
  end

  def home = (@title = 'Introduction')

  def attitudes = (@title = '4 Attitudes')

  def realms = (@title = '4 Realms')

  private

  def delete_add_or_unchanged
    return unless params.key? @tla

    delete || add || Rails.logger.debug { "unchanged #{@tla}: #{params[@tla]}" }
    @cookie_keys.delete(@tla)
  end

  def delete
    return unless cookies[@tla].present? && params[@tla].blank?

    Rails.logger.debug { "deleting #{@tla}: #{params[@tla]}" }
    cookies.delete(@tla)
  end

  def add
    return unless params[@tla] != cookies[@tla]

    Rails.logger.debug { "adding #{@tla}: #{params[@tla]}" }
    cookies[@tla] = params[@tla]
  end
end
