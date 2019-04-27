module Simpler
  class View
    class HtmlRenderer
      VIEW_BASE_PATH = 'app/views'.freeze

      def initialize(env)
        @env = env
      end

      def render(binding)
        template = File.read(template_path)

        ERB.new(template).result(binding)
      end

      private

      def template
        @env['simpler.template']
      end

      def template_path
        path = template || [controller.name, action].join('/')

        Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
      end

      def controller
        @env['simpler.controller']
      end

      def action
        @env['simpler.action']
      end
    end
  end
end
