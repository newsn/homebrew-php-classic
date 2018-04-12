require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class HomebrewPhpRequirement < Requirement
  def fatal?
    true
  end

  def satisfied?
    false
  end

  def message
    "A requirement as failed"
  end
end

