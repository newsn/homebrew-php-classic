require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Twig < AbstractPhp54Extension
  init
  desc "flexible, fast, and secure template language"
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.23.1.tar.gz"
  sha256 "f8643b21ba3b1ad21593567bddbab0ecba07449a7185032ce29fee4249e797f0"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "026a0a94448ae80c5fdf680b1ff6cb2162642136fe8131a18af8a8bf12c34d6a" => :el_capitan
    sha256 "a326a5339f72fb71bc4a5b9d578ea3d1fd67835799e498369becf729777a0752" => :yosemite
    sha256 "ea3c545f7fa63b3312d930337a9c3d96da13a64c4fc9f323a5cb54e6d514e370" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/twig" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/twig.so]
    end
    write_config_file if build.with? "config-file"
  end
end
