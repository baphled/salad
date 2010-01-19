class FeatureFile < File
  def invalid?
    if self.path =~ /^(.*).feature$/
      false
    else
      true
    end
  end

  def feature
    @feature = nil
    self.each do |line|
      if line.strip =~ /^Feature: /
        @feature = line.strip
      end
    end
    @feature
  end

  def in_order
    @in_order = nil
    self.reopen path if self.eof?
    self.each do |line|
      if line.strip =~ /In order/
        @in_order = line.strip
      end
    end
    @in_order
  end

  def i_want
    @i_want = nil
    self.reopen path if self.eof?
    self.each do |line|
      if line.strip =~ /^I want/
        @i_want = line.strip
      end
    end
    @i_want
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