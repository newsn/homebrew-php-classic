require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Rdkafka < AbstractPhp53Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-1.0.0.tgz"
  sha256 "3a8957c618f9f4093c8258621841c543270f4c4cbfd8ee687ca1dc270b244f87"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "b16032808bec797abefeb4f5ddb0759548af0ee0a85159dad9491404f3dabcb6" => :sierra
    sha256 "28f8af5e63156cb3ffbb09dc09b291804c5572e3a7e6d8d401fa3b7cd96bd9f9" => :el_capitan
    sha256 "7e07d82dae206fda3575d97dbfb4d19e71ade5ee485a7104afc249420b38183b" => :yosemite
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
