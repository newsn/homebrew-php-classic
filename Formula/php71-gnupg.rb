require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gnupg < AbstractPhp71Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.4.0.tgz"
  sha256 "35e16bee11345a7d6bf57bea3cadf45e371ad1ed4e0218b0c06f6f637e4e1772"

  bottle do
    cellar :any
    sha256 "a3dda2bdae529dc38b5677fc01abbe770cbe97690c61e18139c969df9f126bae" => :high_sierra
    sha256 "8fff260d622206397818763bc31ac778e05c3a090911f28062f8e7f5a4d60e96" => :sierra
    sha256 "4e8244ed1cbeda3d499bbfebf262d1e42b13f4bbe5addb6233276597eb601537" => :el_capitan
  end

  depends_on "gpgme"

  def install
    Dir.chdir "gnupg-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/gnupg.so"
    write_config_file if build.with? "config-file"
  end
end
