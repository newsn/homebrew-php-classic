require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mosquitto < AbstractPhp55Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.4.0.tgz"
  sha256 "eec599110f733afe5e0331a85d8feb354ec079b088bdca2dd81a587c5b50f8e4"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    sha256 "5216a87cef11e4c40d2f5209af577a15302050563c1e00dd90989d2ea2321f28" => :sierra
    sha256 "57788eae72312bd05e35e9ef028cd7334b650b918e89b9ce3f52319111a1f169" => :el_capitan
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
