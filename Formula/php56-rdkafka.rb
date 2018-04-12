require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Rdkafka < AbstractPhp56Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-1.0.0.tgz"
  sha256 "3a8957c618f9f4093c8258621841c543270f4c4cbfd8ee687ca1dc270b244f87"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "7c0026c9b83386436326cc3d6e72403c7ff804514ceaeabde4be2b46d1699a15" => :sierra
    sha256 "ac7069fd99d255cfa5f4f6d497a6d471e77ec9bcf8349f3f46c379ea57c35f47" => :el_capitan
    sha256 "f867955fd6cacc6f9283e93d0ea614c77c10ea31320b0b542fbffefb4a5ec1e8" => :yosemite
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
