require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || ENV['LOG_FILE_PATH'] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @logger.info(log_message(env, status, headers))

    [status, headers, body]
  end

  private

  def log_message(env, status, headers)
    [
      "\n",
      "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}",
      "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}",
      "Parameters: #{env['simpler.request'].params}",
      "Response: #{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}",
      "\n"
    ].join("\n")
  end
end

