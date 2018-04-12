require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Puli < AbstractPhpPhar
  init
  desc "Universal package system for PHP"
  homepage "http://puli.io"
  url "https://github.com/puli/cli/releases/download/1.0.0-beta10/puli.phar"
  version "1.0.0-beta10"
  sha256 "9aa39070480e5faaf61fb8cb92530cf7fc92ed29e3873a0f79448d6812caef3b"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d0e2c35b1d2d522038632af1e994c52ef6beaf1b312e48efad294132eaa33b1" => :sierra
    sha256 "d1e04930b5149a361aaf9e33592e46ffb03120de02cbc6ee348d0940e8fdc6f6" => :el_capitan
    sha256 "1a100b41fde83d24c6cd64f55becac6aca6eb0129e860b00abbb7dc927862808" => :yosemite
    sha256 "551a1b27dce2810df381ee2e971b27d4681eda6af60f2cf66f48540d5d4caf9c" => :mavericks
  end

  test do
    system "puli", "--version"
  end
end
