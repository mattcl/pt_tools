require 'configatron'
require 'rest_client'

module PtTools
  module API
    def api
      ::PtTools::API.api
    end

    def self.api
      @api ||= RestClient::Resource.new(
        configatron.api.base_path,
        :headers => {'X-TrackerToken' => configatron.api.token}
      )
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def api
        ::PtTools::API.api
      end
    end
  end
end
