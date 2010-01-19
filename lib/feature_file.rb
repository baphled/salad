class FeatureFile < File
  def invalid?
    if self.path =~ /^(.*).feature$/
      false
    else
      true
    end
  end

  def feature
    read_properties /^Feature: /
  end

  def in_order
    read_properties /^In order/
  end

  def i_want
    read_properties /^I want/
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

  private
  def read_properties property
    @value = nil
    self.reopen path if self.eof?
    self.each do |line|
      if line.strip =~ property
        @value = line.strip
      end
    end
    @value
  end
end