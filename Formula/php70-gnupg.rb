require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gnupg < AbstractPhp70Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.4.0.tgz"
  sha256 "35e16bee11345a7d6bf57bea3cadf45e371ad1ed4e0218b0c06f6f637e4e1772"

  bottle do
    cellar :any
    sha256 "345866811db2f186724c9d2072cba674e026e589790653bfe312c4bbf9559bab" => :sierra
    sha256 "dcd534c5c70ac9998a50dc2929fb81c507f24aeba6931c8695dee1f84423054a" => :el_capitan
    sha256 "79502b9ec723cf28aa7e6adf2e983b5f32013da685bedc4eed894b5874bd42d9" => :yosemite
  end

  depends_on "gpgme"

  def install
    Dir.chdir "gnupg-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/gnupg.so"
    write_config_file if build.with? "config-file"
  end
end
