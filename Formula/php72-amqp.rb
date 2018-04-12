require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.3.tgz"
  sha256 "c79e52db33bf907dad7da8f350dbdf2937b0679a3dc44fb2a941efb6d4808da9"
  head "https://github.com/pdezwart/php-amqp.git"
  revision 1

  bottle do
    cellar :any
    sha256 "321246d3b7fab5413d4755ea4bf3da7285f2709a08cee7d1c5d5ea2d33a6cddc" => :high_sierra
    sha256 "6137f055ca5c60907c2f635f01cef77144c20268cb168ea85098889f5d982624" => :sierra
    sha256 "429b0b5dd1e0e7370c538129d19c13a1b88f13b2699dc040b52df10f6e63057e" => :el_capitan
  end

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
