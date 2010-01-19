class FeatureFile < File
  def invalid?
    if self.path =~ /^(.*).feature$/
      false
    else
      true
    end
  end

  def feature
    self.each do |line|
      if line.strip =~ /^Feature: /
        line.strip
      end
    end
  end

  def in_order
    self.each do |line|
      if line.strip =~ /^In order/
        line.strip
      end
    end
  end

  def i_want
    self.each do |line|
      if line.strip =~ /^I want/
        line.strip
      end
    end
  end

  def scenarios
    @scenarios = [] if @scenarios.nil?
    self.each do |line|
      if line.strip =~ /^Scenario: /
        @scenarios << {:scenario => line.strip,:steps => [] }
      elsif line.strip =~ /^(Given|When|Then|And)/
        @scenarios.last[:steps] << line.strip
      end
    end
    @scenarios
  end

  def export
    Feature.new(:title => feature,
               :in_order => in_order,
               :i_want => i_want)
  end
end