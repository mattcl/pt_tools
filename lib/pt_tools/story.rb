module PtTools
  class Story
    attr_reader :raw
    attr_reader :name
    attr_reader :state

    def self.stories(data)
      data.map { |d| Story.new(d) }
    end

    def initialize(data)
      @raw   = data
      @name  = data['name']
      @state = data['current_state']
    end

    def as_table_row
      [state, name]
    end
  end
end
