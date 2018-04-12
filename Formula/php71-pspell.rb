require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 20

  bottle do
    sha256 "3ab6ac458dbd7776f4a52f17b656b4f64bdaae8074b7ef7a4b8a4f03e26c3a4b" => :high_sierra
    sha256 "c4f9939390562d63425b545ffefe3256664f1f80a2e83e76b2aae5de0c9ac1f0" => :sierra
    sha256 "476e2c264ea3796f8be6e61a0235bdc1d6e8dcabd7b343028898bed3d0ebaab2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

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
