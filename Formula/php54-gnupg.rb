require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gnupg < AbstractPhp54Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.3.6.tgz"
  sha256 "50065cb81f1ac3ec5fcd796e58c8433071ff24cc14900e6077682717f5239307"

  bottle do
    cellar :any
    sha256 "392e3a93f964644ae21a5ef8695262ec5c15ed8fe81158c299a2a9b8a903d984" => :el_capitan
    sha256 "dcb54817436592c18ba1bb3c7dce7998b5eabcfe57b2b40ae6398a4f5ad76489" => :yosemite
    sha256 "2848b982d56c98b0588cbb2abf552dd1394bedb7dcd9a6e0e43bb89b505aa537" => :mavericks
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
