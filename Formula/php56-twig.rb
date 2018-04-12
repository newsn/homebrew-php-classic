require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Twig < AbstractPhp56Extension
  init
  desc "flexible, fast, and secure template language"
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.23.1.tar.gz"
  sha256 "f8643b21ba3b1ad21593567bddbab0ecba07449a7185032ce29fee4249e797f0"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5aaa4350110b50b63b8474fa4353ce382b441f9b2c3588f6da4bd8316fc3c161" => :el_capitan
    sha256 "0567b65766478aebcfea3193adaa8bd95c568990d76bb07ce76a19c9ca812029" => :yosemite
    sha256 "23d9df938d8eca69882bf1e685372472cdd45c7b58343dfcd9fa4aa8ff4cb707" => :mavericks
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
