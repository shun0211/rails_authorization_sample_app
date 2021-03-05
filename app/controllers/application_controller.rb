class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  before_action :authenticate_user!
  check_authorization unless: :skip_checking_authorization?

  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  private

  def skip_checking_authorization?
    devise_controller?
  end

  def handle_access_denied(e)
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: e.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
