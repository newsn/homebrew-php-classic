require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PharBuildingRequirement < HomebrewPhpRequirement
  def satisfied?
    `php -i| grep phar.readonly`.downcase.include? "off"
  end

  def message
    "The PHP setting 'phar.readonly' is required to be 'Off' for this formula"
  end
end
