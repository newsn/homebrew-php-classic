require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gnupg < AbstractPhp53Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.3.6.tgz"
  sha256 "50065cb81f1ac3ec5fcd796e58c8433071ff24cc14900e6077682717f5239307"

  bottle do
    cellar :any
    sha256 "dae642f22828516910d1ac63440f7f0f9accb43102d0ee81e4413733f2456aa6" => :el_capitan
    sha256 "6e3f4927bcaafcadb275a59ada0508cb9c6f862dad3cc05ffb6b4176d60ba47d" => :yosemite
    sha256 "e59f0ebddacb83b65f99ce451f7145a0689ade9de8e7387ea28203157ad49662" => :mavericks
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
