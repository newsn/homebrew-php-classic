require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gnupg < AbstractPhp55Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.3.6.tgz"
  sha256 "50065cb81f1ac3ec5fcd796e58c8433071ff24cc14900e6077682717f5239307"

  bottle do
    cellar :any
    sha256 "10a37d93a07acdbc628ddda0be8dd889443dbc485bd98b9ade4b7152d3d2a719" => :el_capitan
    sha256 "a3bdc914f7f64404a123b4f9652723ca7855152b186555ba5150426db615945c" => :yosemite
    sha256 "3fb48396be7d71bc7748a3736200f88cfd7d590e64706eb72dd2a2d1316349f2" => :mavericks
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
