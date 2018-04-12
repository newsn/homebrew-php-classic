require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "Deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v6.0.5/deployer.phar"
  sha256 "e2b1e61aac73dc4ab2f4abfbbc6065ab9af097041c8f0ac33ba263bfa9c52875"

  bottle :unneeded

  def phar_file
    "deployer.phar"
  end

  def phar_bin
    "dep"
  end

  test do
    system "#{bin}/dep", "list"
  end
end
