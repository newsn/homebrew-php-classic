require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Rdkafka < AbstractPhp54Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-1.0.0.tgz"
  sha256 "3a8957c618f9f4093c8258621841c543270f4c4cbfd8ee687ca1dc270b244f87"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "0226bbd615dfad80b31ff175b29e6ec50f6401c4caa56d9adbded6505b13e6d9" => :sierra
    sha256 "10edd100febbba7f3cdc293ddf87011a2b428e7590ff200021f0dd12d9a578e4" => :el_capitan
    sha256 "d776c9eceac6c7382b0f85391960865eac27ef337ae29c59422ff184e9164537" => :yosemite
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
