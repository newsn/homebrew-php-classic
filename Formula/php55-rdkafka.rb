require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Rdkafka < AbstractPhp55Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-1.0.0.tgz"
  sha256 "3a8957c618f9f4093c8258621841c543270f4c4cbfd8ee687ca1dc270b244f87"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "c9ac2b06519bccf6190033b97a6bc01f5169e24c7ba7a8b9b445315822d8ee18" => :sierra
    sha256 "a78a94d2bd1c6c7d0dcad1006b6eb4841a315028e4c2fd41846aee8fa6658d53" => :el_capitan
    sha256 "f9ebbe2c292ec90c0a6180c6e6d7b23193e7e4d302855b0ce4958093ef1717df" => :yosemite
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
