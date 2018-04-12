require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.3.tgz"
  sha256 "c79e52db33bf907dad7da8f350dbdf2937b0679a3dc44fb2a941efb6d4808da9"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "0185813e92e1509b337200b84183271fd465493ad120b6cbd51679135a6c85f8" => :high_sierra
    sha256 "0f5d3cf7d33ce3bf06e75129e3a89605002dbf3c5734d3171662d0cb0ad06014" => :sierra
    sha256 "ee673c070c42a82a8bc2cb15e97d0387a67799319d4b68ef506f3be81a2ad82e" => :el_capitan
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
