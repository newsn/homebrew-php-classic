require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mosquitto < AbstractPhp54Extension
  init
  desc "A wrapper for the Mosquitto MQTT client library for PHP."
  homepage "https://github.com/mgdm/Mosquitto-PHP/"
  url "https://pecl.php.net/get/Mosquitto-0.2.2.tgz"
  sha256 "e9baa3af1d9a62f8fa1b76ffffbd13fffe7b65e0122130fb389915269543915e"
  head "https://github.com/mgdm/Mosquitto-PHP.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "136f0279e39666e90111aaad7c12f54d0211cfa48af5b878b61f1febfd1c2352" => :el_capitan
    sha256 "5f839c42fd7be9ec60b1e01ccf718e5c6f1ef975fb15aec4d0610150be7c53ce" => :yosemite
    sha256 "ffcd74c3991b2bdc816e716ffdc9ba896c21e4cfbba1c7a212c55d847fd1b47a" => :mavericks
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
