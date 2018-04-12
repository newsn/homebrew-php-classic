require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pspell < AbstractPhp54Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 2
    sha256 "713fb33907108094149178b01b88f8246b9c6c8876b10581213deff7985fb590" => :el_capitan
    sha256 "912e0127b19d03eadc8a5437fe923f1f893e819e3908cbf20e624692443c0448" => :yosemite
    sha256 "539234b00ca0167b50c3e46277e59747b044b30eec7582de63af59d579ad80cb" => :mavericks
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
