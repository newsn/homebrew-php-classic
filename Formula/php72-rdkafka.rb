require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Rdkafka < AbstractPhp72Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-3.0.4.tgz"
  sha256 "4cb0a37664810d2a338cf5351e357be7294d99458f76435801e0ed5e328dc5ee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "026fdec5aee6b451685b6ebfd61fab3a330dd9e5421b391a71737a74d3d1f3b6" => :high_sierra
    sha256 "9a7fdd56d9f3d1a055143667f7c9b88e10de4d009f55b24fb3bea5fb3333feb5" => :sierra
    sha256 "44e1d1fca9500c76f1a950b34a84b543796585db0c499ae5e5044a1e5a924556" => :el_capitan
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
