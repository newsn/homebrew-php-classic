require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Rdkafka < AbstractPhp70Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-3.0.4.tgz"
  sha256 "4cb0a37664810d2a338cf5351e357be7294d99458f76435801e0ed5e328dc5ee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "016a029bb8c3ae11f858fe1d65c852a62ec6f76cbd3f9ee9984fbc769ff9d2de" => :high_sierra
    sha256 "b66d8b30390309eb333d14440048fe5d70795f308a7f1fde464dc94da188bcca" => :sierra
    sha256 "d34c7d23f701e256bd5d80301bc8f21de35ae50244359daeea1977cbfd395d42" => :el_capitan
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
