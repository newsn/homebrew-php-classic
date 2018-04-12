require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Twig < AbstractPhp55Extension
  init
  desc "flexible, fast, and secure template language"
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.23.1.tar.gz"
  sha256 "f8643b21ba3b1ad21593567bddbab0ecba07449a7185032ce29fee4249e797f0"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3069084338d0e47c20c7c9c62b2e642a9ff8bb4e9af2113dca3f64250ebc5a66" => :el_capitan
    sha256 "8c524be2df9b0d1b8a17ab71d4c2b5114e76377e6911227c073672ecd669b77f" => :yosemite
    sha256 "0cf0030ea7184054317b07cd8a5f6271d5eb2d6308a613a8ec3440f1d53230b0" => :mavericks
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
