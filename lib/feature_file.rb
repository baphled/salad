class FeatureFile < File
  @file = nil

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
end