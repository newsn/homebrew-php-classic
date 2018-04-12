require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mosquitto < AbstractPhp53Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "59caf80290877cd7bc2dcb8b333cb8b7f999b655138f5e90d59175ef67b54068" => :el_capitan
    sha256 "5eb98d9078b5b771292155c0255d7cb01fe47abbba66d05fc5f693c991f66555" => :yosemite
    sha256 "349155a9505a66d76ecbcaa1658bcabc8ff275d184a6f8dcf2f6323bdbc11be3" => :mavericks
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
