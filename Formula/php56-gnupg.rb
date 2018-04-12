require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gnupg < AbstractPhp56Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.3.6.tgz"
  sha256 "50065cb81f1ac3ec5fcd796e58c8433071ff24cc14900e6077682717f5239307"

  bottle do
    cellar :any
    sha256 "85f6071bed3bb05e08f12dd6a8498d6a4e9f22d98767941b17f15b5ad73f92b7" => :el_capitan
    sha256 "072c99980c6bc2895e78a1fd92b32deb4fafb9bc2dd8e3c8943f43a9eb98b16b" => :yosemite
    sha256 "3b14fc2a5f0103e37858b6b1fc14a52facfc50e9b810802659c40a33e44accdd" => :mavericks
  end

  depends_on "gpgme"

  def install
    Dir.chdir "gnupg-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/gnupg.so"
    write_config_file if build.with? "config-file"
  end
end
