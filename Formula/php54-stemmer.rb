require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Stemmer < AbstractPhp54Extension
  init
  desc "This stem extension for PHP provides stemming capability for a variety of languages."
  homepage "https://github.com/hthetiot/php-stemmer"
  url "https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz"
  sha256 "a3e2769afc0473d85f6d097596e3897a48ee294f071edc8d197fa04c6fc30b9f"
  version "0f32673"

  bottle do
    cellar :any_skip_relocation
    sha256 "a69fd011781b3171e7955dfa09a15c9f323736f8e1ed335f5c8b34bb3f084c95" => :el_capitan
    sha256 "f9579a2eb7d55c5b68f8f73334e48c084e618a96c32305d7b5640d68df3f31dc" => :yosemite
    sha256 "c16a5b46e778a934e8813c13213e4c0f333f7a554869c4d47519d0e4a03c493d" => :mavericks
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
