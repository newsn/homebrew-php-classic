require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpspec < AbstractPhpPhar
  init
  desc "SpecBDD Framework for PHP"
  homepage "https://www.phpspec.net"
  url "https://github.com/phpspec/phpspec/releases/download/3.2.3/phpspec.phar"
  sha256 "ebe3df331f694bb9b4ac6f599b561be088a468f9c9d047696cbd99a74eaf5f31"

  bottle :unneeded

  def phar_file
    "phpspec.phar"
  end

  def phar_bin
    "phpspec"
  end

  test do
    system "#{bin}/phpspec", "--version"
  end
end
