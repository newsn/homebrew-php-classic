require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Uopz < AbstractPhp70Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v5.0.2.tar.gz"
  sha256 "919f6d7873db89a2032e0145a8e7a355d111f9ab2651aa3fa78b636277034dab"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2343cde34c6c0122507e32a1606ac9c2e1f83efc329684e038b111ab029e4fe5" => :sierra
    sha256 "065b5b462aec669ace6c5df8eb3ac81000913fdd60b80abf03e11bd94882ede3" => :el_capitan
    sha256 "e9a175a98125f667ec69bfe969613b024a8d829c31222c59e386c09367dd8901" => :yosemite
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
