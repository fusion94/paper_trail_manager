# This returns the pre-compiled JS for the viewer component.
# Yes, that is a hacky way to make the gem work without
# forcing users to install and integrate an npm package.
class PaperTrailViewer::JsController < ActionController::Base
  protect_from_forgery unless: -> { request.format.js? }

  def show
    send_file js_file, type: 'text/javascript', disposition: 'inline'
  end

  def js_file
    File.join(__dir__, '..', '..', '..', 'javascript', 'compiled.js')
  end
end
