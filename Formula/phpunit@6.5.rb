require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT65 < AbstractPhpPhar
  init
  desc "(Old Stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.6.phar"
  sha256 "ad0d5f8dfbd95ffcbfbe7fde4fa7a9d4f24fa6e070b1215faea579cdefac08f3"

  bottle :unneeded

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat65 --version").include?(version)
  end
end
