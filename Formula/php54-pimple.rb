require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pimple < AbstractPhp54Extension
  init
  desc "Pimple is a simple PHP Dependency Injection Container."
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "da768507b34c5a70d96be8a9a4a603ad8aaff193bb7bb781bb12a62b5f7f5402" => :el_capitan
    sha256 "f40bec3c42a6639c5c299f17e2e023378a8f20dd53d6becee44e8f14cc8eee5d" => :yosemite
    sha256 "85205555101fae5f85528206afd2c39ca68cfc54167a02cb75865a72de182f99" => :mavericks
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
