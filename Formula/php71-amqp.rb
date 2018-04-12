require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Amqp < AbstractPhp71Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.3.tgz"
  sha256 "c79e52db33bf907dad7da8f350dbdf2937b0679a3dc44fb2a941efb6d4808da9"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "58b5c7c6e260efdb8151a0dca97adc0a777dad33a300b21f916d2d18e33e2f6f" => :high_sierra
    sha256 "ecbf310d28bae3277460fbdfb365884e79c7594adde5614c5b2dc7e555ef0973" => :sierra
    sha256 "207fb6b9e61b7547052f4343344fe4824d92c4b6526fb7fc8246b0df7474b901" => :el_capitan
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
