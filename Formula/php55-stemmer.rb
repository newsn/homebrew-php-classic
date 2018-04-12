require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Stemmer < AbstractPhp55Extension
  init
  desc "This stem extension for PHP provides stemming capability for a variety of languages."
  homepage "https://github.com/hthetiot/php-stemmer"
  url "https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz"
  sha256 "a3e2769afc0473d85f6d097596e3897a48ee294f071edc8d197fa04c6fc30b9f"
  version "0f32673"

  bottle do
    cellar :any_skip_relocation
    sha256 "c2f61b39cacf0f8eb823af980b4674cb6b385bc91c2140ba337c709ce29c4268" => :el_capitan
    sha256 "46559f78ae8f8a27195971a791f0e4284ac92c6c2fa58c600fa6bb3b83ad3f0d" => :yosemite
    sha256 "d36f0b58b7e7b950c9335c26948a6b030452ce3dfcd5f8aa2cc6325d42aa2536" => :mavericks
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
