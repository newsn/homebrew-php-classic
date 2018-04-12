require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mosquitto < AbstractPhp72Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.4.0.tgz"
  sha256 "eec599110f733afe5e0331a85d8feb354ec079b088bdca2dd81a587c5b50f8e4"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "ac8a0840038db30ee21552540b5c5134803580f63bf8aba296c8500b3e0e50a2" => :sierra
    sha256 "dde5f0ad882de64c6d8baf55ffb5cfb85271b16a9d99ec7a8324b2e4b2ca4af0" => :el_capitan
  end

  depends_on "mosquitto"

  def install
    Dir.chdir "mosquitto-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mosquitto.so"
    write_config_file if build.with? "config-file"
  end
end
