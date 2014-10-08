require 'pt_tools/api'

module PtTools
  class FilterableResource
    include API

    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end

    def where(filter)
      filter = CGI.escape(filter)
      resource["?filter=#{filter}"]
    end
  end
end
