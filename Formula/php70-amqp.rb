require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.3.tgz"
  sha256 "c79e52db33bf907dad7da8f350dbdf2937b0679a3dc44fb2a941efb6d4808da9"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "6b9bca8dc011c8056404668082e8ef3d016bd509aae6de7136694886336dc9fd" => :high_sierra
    sha256 "9edc6a87c2975b4c021ea2ae10388ef7384a44756f7cee28a6779a3ac24b86f4" => :sierra
    sha256 "98d27e4bd1c6c259fad1f887d5bb2a155c9a3ef5444f48391f8a007c2d3eb690" => :el_capitan
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
