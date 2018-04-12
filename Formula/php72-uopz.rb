require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Uopz < AbstractPhp72Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v5.0.2.tar.gz"
  sha256 "919f6d7873db89a2032e0145a8e7a355d111f9ab2651aa3fa78b636277034dab"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "efa92259246740e40ea4a543545e59a9a1bee0f1f1ad86294d89bbba158e0e89" => :sierra
    sha256 "aa89e3df7242137eae7fb794b3ce2b63a45edb5906b0eadcb6578be841785c5e" => :el_capitan
    sha256 "7a66b625d6ecb691bc6d87c61e2971daf5fe6fa4ab79826e49f66d91a5f1fa54" => :yosemite
  end

  def install
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
end
