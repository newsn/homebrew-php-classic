require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pimple < AbstractPhp55Extension
  init
  desc "Pimple is a simple PHP Dependency Injection Container."
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "de11d652b7bcde594ee31d17533b9041036a3b34953c53431bf4e4f19c87c312" => :el_capitan
    sha256 "d4707f649a53e1d19021de159ea8982ddbb0ad898abf4a3786bab09fdfada06c" => :yosemite
    sha256 "126a013c27d96d8db1268d1f3d481e386534239ab6e1eb56b0bb75242db78dbb" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/pimple" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/pimple.so]
    end
    write_config_file if build.with? "config-file"
  end
end
