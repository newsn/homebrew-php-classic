require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "f9a3fd05faf7e45012f21e98c7cf3f9bacbbabd77b7fbb35aa8032b0535d2761" => :high_sierra
    sha256 "ac3091fb95d97b9b06cd71e074893952cd11726cb58b1bd9a1df8d73a68371a6" => :sierra
    sha256 "7755a9c764a546b7b0f81db3c2778fdb83c97a85d93b24e43b1024a1b35feab1" => :el_capitan
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
