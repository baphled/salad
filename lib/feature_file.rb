# FeatureFile
# Used to handle and manipulate cucumber feature files
#
# @author Yomi Colledge
# @email yomi@boodah.net
#
class FeatureFile < File

  def feature
    read_properties /^Feature: /
  end

  def in_order
    read_properties /^In order/
  end

  def as_a
    read_properties /^As/
  end

  def i_want
    read_properties /^I want/
  end

  def scenarios
    scenarios = [] if scenarios.nil?
    self.reopen path if self.eof?
    self.each do |line| 
      if line.strip =~ /^Scenario: /
        scenarios << Story.new(:scenario => line.strip.sub(/^Scenario: /, ''))
      elsif line.strip =~ /^(Given|When|Then|And)/ and scenarios.last.nil? == false
        scenarios.last.steps << Step.new(:title => line.strip)
      end
    end
    scenarios
  end

  def invalid?
    if self.path =~ /^(.*).feature$/
      false
    else
      true
    end
  end

  def export
    Feature.new(:title => feature,
               :in_order => in_order,
               :as_a => as_a,
               :i_want => i_want,
               :stories => scenarios)
  end

  private

    # @TODO refactor to take a block, allowing us to use this method for scenarios
    def read_properties property
      @value = nil
      self.reopen path if self.eof?
      self.each do |line|
        if line.strip =~ property
          @value = line.strip.sub(property, '')
        end
      end
      @value
    end
end