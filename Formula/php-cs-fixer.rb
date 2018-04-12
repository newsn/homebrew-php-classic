require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.10.0.tar.gz"
  sha256 "4a35e08f1638bf1f6ddaeee57d355e0e43d1fb3008eba9391f7d5684bfb345f3"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fdcb52696e205c7ca70024a0e5fc7fa3cb51d5be6adc054308a763775fe04e9c" => :high_sierra
    sha256 "779855aa6152b0e349818efd5dd5a461cbc177613feca1176e10dcc936dcc1b8" => :sierra
    sha256 "38060defd678eed56536aa2d5b487e0f6e1158b07863ec4c7ee4d600a9cad9d3" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"php-cs-fixer"
  end

  test do
    system "#{bin}/php-cs-fixer", "--version"
  end
end
