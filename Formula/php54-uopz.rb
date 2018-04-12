require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Uopz < AbstractPhp54Extension
  init
  desc "The uopz extension exposes Zend Engine functionality normally used at compilation and execution time."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v2.0.7.tar.gz"
  sha256 "aca7dac96c00e5bd628625ad7372d733c8a40a48d4b143d7f001feea1c5fb3b1"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    sha256 "4ea1c82718843fb7838aff6dad115702a9db8b0b08b1de44222da6f3b79468e3" => :yosemite
    sha256 "1ced161e6d53fc81fd94ca2ad1a5305e1b4171671125e51df186ca5bd329f991" => :mavericks
    sha256 "e27cafc6080ddac8a01795841ee114fdf8f6d9198ddcc0d7653a17f372535a10" => :mountain_lion
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
