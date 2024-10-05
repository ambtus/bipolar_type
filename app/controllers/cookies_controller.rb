class CookiesController < ApplicationController

  def update
    case params[:commit]
    when 'Turn All Off'
      SETTINGS.each {|s| cookies[s] = 'hide'}
    when 'Turn All On'
      SETTINGS.each {|s| cookies.delete(s)}
    when 'Save'
      SETTINGS.each {|s| cookies.delete(s)}
      SETTINGS.each {|s| cookies[s] = 'hide' if params[s] == '0'}
    end
    cookies['count'] = SETTINGS.select {|s| cookies[s] == 'hide' }.count

    redirect_back fallback_location: root_path
  end
end
