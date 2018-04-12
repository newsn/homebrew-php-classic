require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 10
    sha256 "f9031d69810dacc2df6fa20b0a4f1531b4455901826ea9cf9a143f12392802bf" => :el_capitan
    sha256 "df4243bab38e0320ee6d8f4df22329958020e79d802065f9b0afa52503cfc872" => :yosemite
    sha256 "ab077d01af1381f33221dcde496211e598d265e96028adbd02f5e54ec398d2fa" => :mavericks
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end








