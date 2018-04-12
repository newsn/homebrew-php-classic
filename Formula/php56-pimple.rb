require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pimple < AbstractPhp56Extension
  init
  desc "Pimple is a simple PHP Dependency Injection Container."
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8800e7a0c9c696e5ea1de5c324706343d4ae066af01d0ea84a5f419511d04e61" => :el_capitan
    sha256 "60df7292d22c871248f6927ce67f262693a69ddc77d189451498fd77cf51b698" => :yosemite
    sha256 "9815ce167b07fa3da2221b939498946c7a0121bcc7b9c4f890980d74dcffb993" => :mavericks
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
