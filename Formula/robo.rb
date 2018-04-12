require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Robo < AbstractPhpPhar
  init
  desc "Modern Task Runner for PHP"
  homepage "http://robo.li/"
  url "https://github.com/consolidation/Robo/releases/download/1.1.1/robo.phar"
  sha256 "aee018b00ac2190de6d87b80366acc7c685b9915a17c7bb04029d77865299a49"

  bottle :unneeded

  def phar_file
    "robo.phar"
  end

  def phar_bin
    "robo"
  end

  test do
    system "#{bin}/robo", "--version"
  end
end
