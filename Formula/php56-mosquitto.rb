require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mosquitto < AbstractPhp56Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.4.0.tgz"
  sha256 "eec599110f733afe5e0331a85d8feb354ec079b088bdca2dd81a587c5b50f8e4"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "c95d7ae1de50d10348b51a5d1b550cc92673a3270722078908bc041b6e299e03" => :sierra
    sha256 "7102f829240f4bb1f9516be6116d3221f03142b4e9c05ac3f3424d5f8be298ed" => :el_capitan
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
