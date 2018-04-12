require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pimple < AbstractPhp53Extension
  init
  desc "Pimple is a simple PHP Dependency Injection Container."
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d9bb53ce7909f892de6e54d90b2bc64f445031908b945bd1b9397148943d9714" => :el_capitan
    sha256 "ab580b1537fde846bd2a8abbb0eb1d7cf8f285296144a36858edd7cab9cb2c85" => :yosemite
    sha256 "ac7ce01167896cb2dbe4d48606e5938e055420ba40430c64f9993a4b2d404ff3" => :mavericks
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
