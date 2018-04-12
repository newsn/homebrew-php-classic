require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Sodium < AbstractPhp54Extension
  init
  desc "Modern and easy-to-use crypto library using libsodium."
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.2.0.tar.gz"
  sha256 "cf8365e5d4862bfbd61783e0e8cdf4ddbf0124a1d93492c33a8a05919af08893"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    cellar :any
    sha256 "0ad1471ec8eba46fc41d41f212a9cdd1c6dea83cd3c8f377865cd6b64c7f6a9e" => :high_sierra
    sha256 "b7d58a22e7607bfa0b528737081ebe22b060debc4763d6f6b0aa65edeb6fcee7" => :sierra
    sha256 "2cd157b9fb4dc283887f313150e9ce7dcb7e6cc91ab494d97e2fe07c97b18e90" => :el_capitan
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
