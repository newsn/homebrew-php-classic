require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 9
    sha256 "78cc3183624dc9002f24869a6c3f9b0b712620293106ae6f84a12f6ee8668856" => :el_capitan
    sha256 "b807e048284cd565fb5498c89b3f4675db1e7baf3b1c5454722c650c9bcf3cde" => :yosemite
    sha256 "59e2b13cf4ccc9e099761804f1bc08ccda916f8fee86a1fd5fd33a4ec7deb53f" => :mavericks
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








