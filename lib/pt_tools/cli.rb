require 'thor'
require 'configatron'
require 'yaml'
require 'pt_tools/api'

module PtTools
  class CLI < Thor
    include Thor::Actions
    include API

    def initialize(*args)
      super
      configure
    end

    class_option :config,
      aliases: '-c',
      type: :string,
      default: File.join(ENV['HOME'], '.pt_tools.yml'),
      desc: 'path to the config file'

    desc 'me', 'get account info'
    def me
      say api['me'].get
    end

    desc 'projects', 'list projects'
    def projects
      res = api['projects'].get
      data = JSON.parse(res.body)
      data.each do |f|
        say "#{f['id']}: #{f['name']}"
      end
    end

    desc 'stories PROJECT', 'show stories'
    def stories(project_id)
      res = api["projects/#{project_id}/stories"].get
      data = JSON.parse(res.body)
      require 'pp'
      pp data
    end

    protected

    def configure
      conf = YAML.load_file(options[:config])
      configatron.configure_from_hash(conf)
    end
  end
end
