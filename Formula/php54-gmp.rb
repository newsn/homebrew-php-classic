require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gmp < AbstractPhp54Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 1
    sha256 "90199e5572b886317f364967450fcb8ed19f0e2310788a4be1b2a256726c65da" => :yosemite
    sha256 "9a324b857787ccfd223baca04ae1312f970f5f39a3ad877729201c1871ad8c2c" => :mavericks
    sha256 "af48fc125deade231b26734f97c01db12fa0f051de08713de389d21d80fdc575" => :mountain_lion
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
