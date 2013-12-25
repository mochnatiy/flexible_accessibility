module FlexibleAccessibility
  module ControllerMethods
  	module ClassMethods

      # Compatibility with previous versions
      def skip_authorization_here
        not_authorize :all
      end

      # Macro for define actions without authorization
      def not_authorize(args={})
        valid_arguments = parse_and_validate_arguments(args)
        self.instance_variable_set(:@_non_verifiable_routes, self.action_methods) if valid_arguments[:all]
        self.instance_variable_set(:@_non_verifiable_routes, valid_arguments[:only]) unless valid_arguments[:only].nil?
        self.instance_variable_set(:@_verifiable_routes, []) if self.instance_variable_get(:@_non_verifiable_routes).nil?
      end

      # Macro for define actions with authorization
  	  def authorize(args={})
        valid_arguments = parse_and_validate_arguments(args)
        self.instance_variable_set(:@_verifiable_routes, valid_arguments[:only]) unless valid_arguments[:only].nil?
        self.instance_variable_set(:@_verifiable_routes, self.action_methods - valid_arguments[:except]) unless valid_arguments[:except].nil?
        self.instance_variable_set(:@_verifiable_routes, self.action_methods) if valid_arguments[:all]
        self.instance_variable_set(:@_non_verifiable_routes, []) if self.instance_variable_get(:@_non_verifiable_routes).nil?
  	  end

      private
      # Parse arguments from macro calls
      def parse_and_validate_arguments(args={})
        result = {}
        (result[:all] = true) and return result if args.to_s == 'all'
        [:only, :except].each do |key|
          unless args[key].nil?
            raise ActionsValueException unless args[key].instance_of?(Array)
            result[key] = args[key].map!{ |v| v.to_s }.to_set
          end
        end
        result
      end
    end
 
    # Callback is needed for include methods and define helper method
    def self.included(base)
      base.extend(ClassMethods)
      base.helper_method(:has_access?)
    end
    
    # Check the url for each link in view to show it
    def has_access?(permission, user)
      raise UnknownUserException if user.nil?
      AccessProvider.is_action_permitted_for_user?(permission, user)
    end
  end
end

# Include methods in ActionController::Base
if defined?(ActionController::Base)
	ActionController::Base.class_eval do
	  include FlexibleAccessibility::ControllerMethods
	end
end
