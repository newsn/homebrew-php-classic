require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Uopz < AbstractPhp71Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v5.0.2.tar.gz"
  sha256 "919f6d7873db89a2032e0145a8e7a355d111f9ab2651aa3fa78b636277034dab"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d9d3ace02649fb8f0ea2ac58a82954f46066173f1a8f5adec96c1ec9314a2ca" => :sierra
    sha256 "e227f8c885bb5b99382657c229e209f17afe6fc8dda38a71011a9d0c77ab2365" => :el_capitan
    sha256 "3c1f5a78f926ecdcf5cc842e0a6bca7c0a98199b7c152ce599fd4524daedb38d" => :yosemite
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
