require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Twig < AbstractPhp53Extension
  init
  desc "flexible, fast, and secure template language"
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.23.1.tar.gz"
  sha256 "f8643b21ba3b1ad21593567bddbab0ecba07449a7185032ce29fee4249e797f0"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "296c291d9e4ae893ce366219664df53926a04b2a63c88d020240b81b08cd1cd4" => :el_capitan
    sha256 "0f0dcf311f7108b9ff761dce91a16f07c7035795c87f6917eda44c6f3f3f8376" => :yosemite
    sha256 "b3a9fea37967237731a40f4b274e033f2df92d0de55aa58ca50d0cf1026207a5" => :mavericks
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
