# This formula tracks the 0.13 branch of Terminus
# Terminus 1.0 is a major breaking change and users may need time to adapt
require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class TerminusAT013 < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.6.tar.gz"
  sha256 "c71a0983edf93879e14da00f08128a0a47d493d4aaf4ccf58a86c3f6b5e74c95"
  head "https://github.com/pantheon-systems/terminus.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "9382caa68759f848ea15c35f49c592adc12add871a4a0b61d6d564301c825664" => :sierra
    sha256 "13d19e24cf8d8546fa97ba0e46d7cbf6640e5e2f1901f4e691a7b037a81d0a16" => :el_capitan
    sha256 "3817d9e7b5463a20d6dab9f1f3423aacef5aa54d3d2cf52c77710020c419647e" => :yosemite
  end

  keg_only :versioned_formula

  depends_on PhpMetaRequirement

  def install
    composer_install

    rm "bin/terminus.bat"
    rm "bin/behat"

    prefix.install Dir["*"]
  end

  test do
    system bin/"terminus", "cli", "version"
  end
end
