require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library using libsodium."
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.2.0.tar.gz"
  sha256 "cf8365e5d4862bfbd61783e0e8cdf4ddbf0124a1d93492c33a8a05919af08893"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    cellar :any
    sha256 "d22d22acb631dbf47e22d1eef16c3043865740e7a7d3ac0bc3ec793f60cad75f" => :high_sierra
    sha256 "07402ea4817c66f814ed53f0e8dc8bd4f5077b99fe23e640e1f0d8542fcfa347" => :sierra
    sha256 "b45319467694165a1451614af6407add84ccd525e040e26014dfabf89c94e83a" => :el_capitan
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
