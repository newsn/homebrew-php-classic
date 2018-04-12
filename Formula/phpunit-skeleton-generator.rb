require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitSkeletonGenerator < AbstractPhpPhar
  init
  desc "Generate skeleton test classes"
  homepage "http://phpunit.de/manual/current/en/"
  url "https://phar.phpunit.de/phpunit-skelgen-2.0.1.phar"
  sha256 "d23d31304348faf2fad6338c498d56864c5ccb772ca3d795fea829b7db45c747"

  bottle do
    cellar :any_skip_relocation
    sha256 "fd583e022bd496a9a30d7bfafc1a2d9aa7807ea010c95179f4e953d0681984f2" => :sierra
    sha256 "ff9fa95042970f93cffe003c61f8c56fc92a86d7f9d5f227f02a14521df3971f" => :el_capitan
    sha256 "5981d865ba2158e2985854efe03f5fd94be7322c13c08e79f7f8336b592e8091" => :yosemite
    sha256 "35546d26281be364ee8e04a13eceaaa3ffc201099f6e5273eb4cc0de5a0c8a52" => :mavericks
  end

  def phar_file
    "phpunit-skelgen-#{version}.phar"
  end

  test do
    system "phpunitskeletongenerator", "--version"
  end
end
