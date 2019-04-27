require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private


    def status(code)
      @response.status = code.to_i
    end

    def headers
      @response
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params.update(@request.env['simpler.route_params'])
    end

    def render(resource)
      if resource.is_a?(Hash)
        type, value = resource.first
        @request.env['simpler.template_type'] = type
        @request.env['simpler.value'] = value
        headers['Content-Type'] = 'text/plain' if type == :plain
      else
        @request.env['simpler.template'] = template
      end
    end
  end
end

