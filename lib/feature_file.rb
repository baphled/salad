class FeatureFile < File
  @file = nil

  def initialize featureFile
    @file = featureFile
  end

  def invalid?
    if @file =~ /^(.*).feature$/
      false
    else
      true
    end
  end
end