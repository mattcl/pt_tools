require 'pt_tools/api'
require 'pt_tools/filterable_resource'

module PtTools
  class Project
    include API

    attr_reader :id
    attr_reader :resource

    def initialize(args = {})
      self.id = args[:id]
    end

    def id=(val)
      @id = val
      @resource = api["/projects/#{id}"]
    end

    def stories
      # make a new resource by appending 'stories' to the current resource path
      FilterableResource.new(resource['stories'])
    end
  end
end
