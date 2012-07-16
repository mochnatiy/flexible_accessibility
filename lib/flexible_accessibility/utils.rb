module FlexibleAccessibility
  class Utils
    def initialize
      @path = "#{::Rails.root}/app/controllers/"
      @controllers = []
    end

    def get_controllers
      get_controllers_recursive @path
    end

    def get_controllers_recursive path
      (Dir.new(path).entries - ["..", "."]).each do |entry|
        if File.directory? path + entry
          get_controllers_recursive path + entry + '/'
        else
          @controllers << File.basename(path + entry, ".*") if File.extname(path + entry) == '.rb'
        end
      end
      @controllers
    end
  end
end