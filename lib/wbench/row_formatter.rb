module WBench
  class RowFormatter
    def initialize(name, values)
      @name   = name
      @values = values
    end

    def to_s
      name_s + fastest_s + median_s + slowest_s + std_dev_s
    end

    private

    def name_s
      name = @name.to_s.dup
      name.gsub!(/([a-z\d])([A-Z])/,'\1 \2')
      name.gsub!(/\b('?[a-z])/) { $1.capitalize }
      name.gsub!('Dom ', 'DOM ')
      name = "#{name}:"
      name.ljust(35)
    end

    def fastest_s
      "#{@values.min}ms".ljust(10).colorize(:green)
    end

    def slowest_s
      "#{@values.max}ms".ljust(10).colorize(:red)
    end

    def median_s
      median = @values[ @values.length / 2 ]

      "#{median}ms".ljust(10).colorize(:blue)
    end

    def std_dev_s
      sum = @values.inject(:+)
      sample_variance = (1/@values.length.to_f*sum)
      std_dev = Math.sqrt(sample_variance).to_i

      "#{std_dev}ms".ljust(10).colorize(:yellow)
    end
  end
end