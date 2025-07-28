# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cookies

  def set_cookies
    had_any = false
    cookie_keys = cookies.to_h.keys
    Subtype.each do |subtype|
      k = subtype.tla
      next unless params.key? k

      had_any = true
      if cookies[k].present? && (params[k].blank? || params[k] == subtype.action)
        Rails.logger.debug { "deleting #{k}: #{params[k]}" }
        cookies.delete(k)
        cookie_keys.delete(k)
      elsif params[k].present? && (params[k] != cookies[k])
        Rails.logger.debug { "adding #{k}: #{params[k]}" }
        cookies[k] = params[k]
        cookie_keys.delete(k)
      elsif params[k].present? && (params[k] == cookies[k])
        Rails.logger.debug { "unchanged #{k}: #{params[k]}" }
        cookie_keys.delete(k)
      end
    end
    return unless had_any

    cookie_keys.each { |k| cookies.delete(k) }
  end

  def home = (@title = 'Introduction')

  def attitudes = (@title = '4 Attitudes')

  def realms = (@title = '4 Realms')
end
