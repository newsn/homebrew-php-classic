require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Stemmer < AbstractPhp56Extension
  init
  desc "This stem extension for PHP provides stemming capability for a variety of languages."
  homepage "https://github.com/hthetiot/php-stemmer"
  url "https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz"
  sha256 "a3e2769afc0473d85f6d097596e3897a48ee294f071edc8d197fa04c6fc30b9f"
  version "0f32673"

  bottle do
    cellar :any_skip_relocation
    sha256 "01b1c7c1083f010c0264901fc226dda88a8b81bb667470690f61bded0471f0ce" => :el_capitan
    sha256 "05a22a49c804338ec0f8bb8412d86cf833667a3797d12bd643c44c829a48b418" => :yosemite
    sha256 "26497e229c0e1a7359d1b75a3dafc1b84953fc087da1b802c83b079c504ecaec" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make -C libstemmer_c"
    system "make"
    prefix.install "modules/stemmer.so"
    write_config_file if build.with? "config-file"
  end
end
