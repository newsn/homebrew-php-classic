require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gmp < AbstractPhp53Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "91cc0be428f886c4c4cb80435643713fd325dc2c4b1cea7aac222f0cbd9245d0" => :yosemite
    sha256 "9dfb1bb51ec53e89e434129a39fb23f84d5d9600f1d06fc13f36568862cd37bf" => :mavericks
    sha256 "61e4853eb0dcfb6d74756669804a79906617810f0a1db7e618f3bd7813aa1829" => :mountain_lion
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
