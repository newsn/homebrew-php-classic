require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Rdkafka < AbstractPhp71Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-3.0.4.tgz"
  sha256 "4cb0a37664810d2a338cf5351e357be7294d99458f76435801e0ed5e328dc5ee"
  head "https://github.com/arnaud-lb/php-rdkafka.git"

  bottle do
    cellar :any
    sha256 "56a287d8190abfa54619bd12d44347c153c48f491cb06be82d936f66cf240459" => :high_sierra
    sha256 "ed756762a8fb0a068d6160d4773506dff162fc5f4bc127b7bcb2b9bdee7f7145" => :sierra
    sha256 "4601949c933a4fe4ccadc0802fe629332430ba05ed7bd316c9bb51d0a0e9de5f" => :el_capitan
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
