require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mosquitto < AbstractPhp70Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.4.0.tgz"
  sha256 "eec599110f733afe5e0331a85d8feb354ec079b088bdca2dd81a587c5b50f8e4"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "f24607ee6129564ade7415f78a333c2467c58b091a41472b6e0304b8ca75c51e" => :sierra
    sha256 "4a3c22d26804747d27b6914524562bc384c062fe85632cf8c85c31221e969b20" => :el_capitan
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
