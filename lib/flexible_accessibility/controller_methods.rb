module FlexibleAccessibility
  module ControllerMethods
    module ClassMethods

      # Compatibility with previous versions
      def skip_authorization_here
        authorize skip: :all
      end

      # Macro for define routes table with authorization
      def authorize(args={})
        arguments = parse_arguments(args)

        validate_arguments(arguments)

        self.instance_variable_set(:@_routes_table, arguments)
      end

      private

      # Parse arguments from macro call
      def parse_arguments(args={})
        result = {}

        if args.to_s == 'all'
          result[:all] = ['all'].to_set
          return result
        end

        %i(only except skip).each do |key|
          unless args[key].nil?
            if args[key].to_s == 'all' && key == :skip
              result[key] = [args[key].to_s].to_set
              next
            end

            unless args[key].instance_of?(Array)
              raise ActionsValueException
            end

            result[key] = args[key].map!{ |v| v.to_s }.to_set
          end
        end

        result
      end

      # Validate arguments from macro call
      def validate_arguments(args={})
        return if args.count == 1 && args.keys.include?(:all)

        only_options = args[:only] || Set.new
        except_options =  args[:except] || Set.new
        skip_options = args[:skip] || Set.new

        unless (only_options & except_options).empty? &&
          (only_options & skip_options).empty?

          raise IncorrectArgumentException.new(
            nil,
            'The same arguments shouldn\'t be used with different keys excluding except and skip'
          )
        end

        if args[:skip] == 'all' && args.count > 1
          raise IncorrectArgumentException.new(
            nil,
            'Option \'skip\' with argument \'all\' shouldn\'t be used with another options'
          )
        end
      end
    end

    # Check the url for each link in view to show it
    def has_access?(permission, user)
      raise UnknownUserException if user.nil?

      AccessProvider.is_action_permitted_for_user?(permission, user)
    end

    # Callback is needed for include methods and define helper method
    def self.included(base)
      base.extend(ClassMethods)
      base.helper_method(:has_access?)
    end
  end
end

# Include methods in ActionController::Base
if defined?(ActionController::Base)
  ActionController::Base.class_eval do
    include FlexibleAccessibility::ControllerMethods
  end
end
