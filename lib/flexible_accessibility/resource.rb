module FlexibleAccessibility
  class ApplicationResource
    attr_reader :controller, :namespace

    def initialize(resource_string)
      @controller = resource_string.split('/').last

      @namespace = if resource_string.split('/').first == @controller
        'default'
      else
        resource_string.split('/').first
      end
    end

    def klass
      if standard_resource?
        @controller.camelize.constantize
      else
        (@namespace.camelize + '::' + @controller.camelize).constantize
      end
    end

    def standard_resource?
      @namespace == 'default'
    end
  end
end
