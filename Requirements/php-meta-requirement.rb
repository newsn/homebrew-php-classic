require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  def satisfied?
	which("php")
  end

  def message
    <<~EOS
    Missing a core php install from homebrew-php. 
    Please run: brew install php72
    or install another php version from the homebrew-php tap
    EOS
  end
end
