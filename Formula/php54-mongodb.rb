require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.11.tgz"
  sha256 "bac347be2277dd64b1b6f414234a6057eccf2d208409ce60973107a41267df49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "10146b765e3085867c9c66bbc6831a9f26a4e4218864a471235e37db7235e93c" => :high_sierra
    sha256 "61e792f73bf30770ddcc873f95ea11dbcc379a056b82ceb5a3907d1573618bf7" => :sierra
    sha256 "fd99e7d94331734adfa089926813400bc44508190a4da8d618ee5c2b302c87d6" => :el_capitan
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
