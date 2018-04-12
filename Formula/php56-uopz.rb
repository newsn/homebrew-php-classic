require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Uopz < AbstractPhp56Extension
  init
  desc "The uopz extension exposes Zend Engine functionality normally used at compilation and execution time."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v2.0.7.tar.gz"
  sha256 "aca7dac96c00e5bd628625ad7372d733c8a40a48d4b143d7f001feea1c5fb3b1"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    sha256 "8387f9c399c26e0645f4963db430d89964840d0884b43715597cda0db9f36f7e" => :yosemite
    sha256 "4cd784d6c827374ba0d05a9aa3e1eeab55f18639f5b90fb6277ce1c0b398c43a" => :mavericks
    sha256 "cc75ad526c6512433001094bf48c403f4045734153f4e772f15b8de1060569cf" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uopz.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    caveats = super

    caveats << "  *\n"
    caveats << "  * Important note:\n"
    caveats << "  * Make sure #{config_scandir_path}/#{config_filename} is loaded\n"
    caveats << "  * after #{config_scandir_path}/ext-opcache.ini. Like renaming\n"
    caveats << "  * ext-opcache.ini to opcache.ini.\n"
  end

  def extension_type
    "zend_extension"
  end
end
