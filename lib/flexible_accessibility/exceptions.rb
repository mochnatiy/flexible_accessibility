module FlexibleAccessibility
  class FlexibleAccessibilityException < StandardError
    attr_reader :action, :subject

    def initialize(action=nil, subject=nil)
      @action = action
      @subject = subject
    end

    def to_s
      message || default_message || @subject
    end

    def message
      @subject || nil
    end

    private

    def default_message
      'An exception is occurred'
    end
  end

  class AccessDeniedException < FlexibleAccessibilityException
    def message
      I18n.t('flexible_accessibility.errors.access_denied', action: @action)
    end

    private

    def default_message
      "The access for resource #{@action} is denied"
    end
  end

  class UserNotLoggedInException < FlexibleAccessibilityException
    def message
      I18n.t('flexible_accessibility.errors.user_is_not_logged_in')
    end

    private

    def default_message
      'Current user is not logged in'
    end
  end

  class NoWayToDetectLoggerUserException < FlexibleAccessibilityException
    def message
      I18n.t('flexible_accessibility.errors.no_way_to_detect_logged_user')
    end

    private

    def default_message
      <<-TXT
        No way to detect a logged user,
        maybe you have forgot to define a current_user helper
      TXT
    end
  end

  class UnknownUserException < FlexibleAccessibilityException
    def message
      I18n.t('flexible_accessibility.errors.unknown_user')
    end

    private

    def default_message
      'Probably you have forgot to send a user in has_access?'
    end
  end

  class ActionsValueException < FlexibleAccessibilityException
    def message
      I18n.t('flexible_accessibility.errors.incorrect_value_of_actions')
    end

    private

    def default_message
      <<-TXT
        The value of any 'authorize' macro argument should be declared as Array
      TXT
    end
  end

  class IncorrectArgumentException < FlexibleAccessibilityException
    private

    def default_message
      nil
    end
  end

  class NoWayToDetectAvailableRoutesException < FlexibleAccessibilityException
    private

    def default_message
      'No way to detect an available routes'
    end
  end
end
