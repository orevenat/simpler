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
        current_path = "#{path}.html.erb"

        @env['simpler.template_path'] = current_path
        Simpler.root.join(VIEW_BASE_PATH, current_path)
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
