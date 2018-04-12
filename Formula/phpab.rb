require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpab < AbstractPhpPhar
  init
  desc "Lightweight php namespace aware autoload generator"
  homepage "https://github.com/theseer/Autoload"
  url "https://github.com/theseer/Autoload/releases/download/1.24.1/phpab-1.24.1.phar"
  sha256 "83ccd5328ed24ca4ea061b88da4a450f7246266b9452501c24bc5b02b9cf8eed"

  bottle :unneeded

  def phar_file
    "phpab-#{version}.phar"
  end

  test do
    system "#{bin}/phpab", "--version"
  end
end
