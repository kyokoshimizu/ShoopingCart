class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #rescue_from Exception, with: :handle_500
  #rescue_from ActionController::RoutingError, with: :handle_404
  #rescue_from ActiveRecord::RecordNotFound,   with: :handle_404

  #def handle_500(exception = nil)
   # logger.info "Rendering 500 with exception: #{exception.message}" if exception
	 # render template: 'shared/_error_500'
  #end

  #def handle_404(exception = nil)
  #  logger.info "Rendering 404 with exception: #{exception.message}" if exception
	#  render template: 'shared/_error_404'
 # end

end
