require 'thor'
require 'configatron'
require 'yaml'
require 'pt_tools/api'
require 'pt_tools/project'
require 'pt_tools/story'

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

    desc 'scrum', 'overview for scrum'
    def scrum
      project_id = configatron.scrum.project_id
      labels = configatron.scrum.labels.map { |l| "label:#{l}" }.join(' OR ')
      filter = "(#{labels}) AND (#{configatron.scrum.filter})"
      res = Project.new(:id => project_id).stories.where(filter).get
      data = JSON.parse(res.body)
      stories = Story.stories(data)
      output = stories.collect { |s| s.as_table_row }
      print_table(output)
    end

    protected

    def configure
      conf = YAML.load_file(options[:config])
      configatron.configure_from_hash(conf)
    end
  end
end
