require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Kafka < AbstractPhp53Extension
  init
  desc "PHP extension for Apache Kafka"
  homepage "https://github.com/EVODelavega/phpkafka/"
  url "https://github.com/EVODelavega/phpkafka/archive/6a0908803ab6e9d862097e99f84aeb0fff9ecf03.tar.gz"
  version "rev-6a09088"
  sha256 "f76933b8dea53f822028368380f83e3d4c13ef93811e2014e023408ce4920357"
  head "https://github.com/EVODelavega/phpkafka.git"

  depends_on "librdkafka" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-kafka"
    system "make"
    prefix.install "modules/kafka.so"
    write_config_file if build.with? "config-file"
  end
end
