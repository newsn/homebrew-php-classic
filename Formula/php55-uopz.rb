require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Uopz < AbstractPhp55Extension
  init
  desc "The uopz extension exposes Zend Engine functionality normally used at compilation and execution time."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v2.0.7.tar.gz"
  sha256 "aca7dac96c00e5bd628625ad7372d733c8a40a48d4b143d7f001feea1c5fb3b1"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    sha256 "c4bf55e189c45a6face4303cef82d701cfc61cdebf3427a6539ad264761a06b8" => :yosemite
    sha256 "a10d58aea5d5e74684da1130d324e4c3b3aec40340b3be6c92b461d9ab7851b1" => :mavericks
    sha256 "1c7fe3a31da675efc3436d1ee5f01fdcf36f4df3e77e7c7c02c37c844eeef853" => :mountain_lion
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
