require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Boris < Formula
  include Language::PHP::Composer

  desc "Tiny REPL for PHP"
  homepage "https://github.com/borisrepl/boris/"
  url "https://github.com/borisrepl/boris/archive/v1.0.10.tar.gz"
  sha256 "06eb9e8efe5ceac00f49ba32731c65047435ab09ff57bbbec56c8c728861a2ee"
  head "https://github.com/borisrepl/boris.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "06ec5562b4f22fe3ad5e8ec82873975f028aecbb9afb5e539cfebca802302b73" => :sierra
    sha256 "0d80a4137e4a5924d1bea6549d5b20f90e08c15b3e33bf2c57af8fa19efc6a53" => :el_capitan
    sha256 "689ea4dd37b6a5019bbdb50f87e0ac9806d6a54aa318248aafa9949c45034b63" => :yosemite
    sha256 "e1ebb95b4a0107582b5460a9f1a4d9043e82578461db46ffbced3302caa2d721" => :mavericks
  end

  depends_on PhpMetaRequirement

  def install
    # ensure the required php modules are installed
    php_modules = Utils.popen_read("php -m")
    raise "php must be re-compiled, in order to have readline support" unless php_modules.include?("readline")
    raise "php must be re-compiled with pcntl support" unless php_modules.include?("pcntl")
    raise "php must be re-compiled with posix support" unless php_modules.include?("posix")

    composer_install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/boris"
  end

  test do
    system "boris", "-h"
  end
end
