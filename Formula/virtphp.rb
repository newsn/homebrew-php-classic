require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Virtphp < AbstractPhpPhar
  init
  desc "1 Box, Multiple Elephpants"
  homepage "http://virtphp.org"
  url "https://github.com/virtphp/virtphp/releases/download/v0.5.2-alpha/virtphp.phar"
  version "0.5.2-alpha"
  sha256 "776bce2f6dfd252ef9d886f14d8bbca7cb9e328e69ad900cdf14a552e7e59d30"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ca6c0232cd06c9398c8487a773f68b154af5e7bf9da4acdc88baf8bf9296d59" => :sierra
    sha256 "c6b2be62bf471b4336ceaf56fe3308e8824e900553c17d18f6743c131bbb3b23" => :el_capitan
    sha256 "a20d58dd744492fea668634518551c45b889f0cab5b48557754f49c4d8b55bb1" => :yosemite
    sha256 "283f2a36b66c10ae9d236b134c82843e4a1cb6adde2bf380091b634197185846" => :mavericks
  end

  test do
    system "virtphp", "--version"
  end
end
