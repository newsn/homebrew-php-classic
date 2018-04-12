require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Stemmer < AbstractPhp53Extension
  init
  desc "This stem extension for PHP provides stemming capability for a variety of languages."
  homepage "https://github.com/hthetiot/php-stemmer"
  url "https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz"
  sha256 "a3e2769afc0473d85f6d097596e3897a48ee294f071edc8d197fa04c6fc30b9f"
  version "0f32673"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa183135d748e3f27fab65fac59eb90531a53649d429b1420c16c0867917c5c2" => :el_capitan
    sha256 "586a4010d7696b32377bc06fe28d6b87cb2b59339b0962525d0f72b7cab255ff" => :yosemite
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
