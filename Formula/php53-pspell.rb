require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pspell < AbstractPhp53Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "5b34ccda27538ad3ff37c662b59f7cd245f4d288199421553fc094ad7dc7a207" => :el_capitan
    sha256 "473ac749f0dc97ce2710dca2349cbbf8e2ff16969e1897216e628d8a0ddc544c" => :yosemite
    sha256 "a09f194f50e8aa10734ebea75fccca84f76328689098a47002254dc21a0d4d9b" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
