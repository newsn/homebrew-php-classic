require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Sodium < AbstractPhp55Extension
  init
  desc "Modern and easy-to-use crypto library using libsodium."
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.2.0.tar.gz"
  sha256 "cf8365e5d4862bfbd61783e0e8cdf4ddbf0124a1d93492c33a8a05919af08893"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    cellar :any
    sha256 "02c394d835e735231409291fff9c6e535dc115829cbadf74ae94c66b36b536dc" => :high_sierra
    sha256 "f336084d86ca6db5cff62f42674fe3d78e00f47b6792c0261f825018bb384998" => :sierra
    sha256 "9da5f6733ddb6a5dcaf5b23b6c0609dfd1bd932c173546f4e05edfce19979c37" => :el_capitan
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
