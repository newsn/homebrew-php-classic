require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mosquitto < AbstractPhp71Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.4.0.tgz"
  sha256 "eec599110f733afe5e0331a85d8feb354ec079b088bdca2dd81a587c5b50f8e4"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "fc22272d33671c97b9ab37151750ad7a535cd866f742d6428ca3df4f960d37ea" => :sierra
    sha256 "fbfce2a53a84f19ae67c64a85f1ec9b1aeb6e4199f281e796ebe4afe04e5da5b" => :el_capitan
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
