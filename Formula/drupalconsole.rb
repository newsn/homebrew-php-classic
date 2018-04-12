require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.6.1/drupal.phar"
  sha256 "e3d044988bf96f6062a28f6457f37cfa00ab35461af4c597e936471f202e0194"

  bottle do
    cellar :any_skip_relocation
    sha256 "8a3f182521a3715dd21d8b59f00b7fb4edd60265ade6791915b09f778380b758" => :high_sierra
    sha256 "8a3f182521a3715dd21d8b59f00b7fb4edd60265ade6791915b09f778380b758" => :sierra
    sha256 "8a3f182521a3715dd21d8b59f00b7fb4edd60265ade6791915b09f778380b758" => :el_capitan
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
