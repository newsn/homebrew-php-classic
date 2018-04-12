require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.6.0/phpmd.phar"
  sha256 "69bec1176370a3bcbb81e1d422253f70305432ecf5b2c50d04ec33adb0e20f7a"
  head "https://github.com/phpmd/phpmd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c0f17cc4a6298a5664f3ba0fad7a71d5dbef36f7161ee5d418e992498a2e83e" => :sierra
    sha256 "d91ab44fa02316fa36240883834e0d0dce585c1379617b8782c9f4f7950cb48a" => :el_capitan
    sha256 "d91ab44fa02316fa36240883834e0d0dce585c1379617b8782c9f4f7950cb48a" => :yosemite
  end

  test do
    system "#{bin}/phpmd", "--version"
  end
end
