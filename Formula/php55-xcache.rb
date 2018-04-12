require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xcache < AbstractPhp55Extension
  init
  desc "XCache is a fast, stable ​PHP opcode cacher."
  homepage "http://xcache.lighttpd.net"
  url "http://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.bz2"
  sha256 "7d12a3cbd5f729b70f9226ac19406d11219f1c5f5e82b3bbb43ea9460cbf6cbd"

  bottle do
    cellar :any_skip_relocation
    sha256 "04ccd0c4870dfe2e4ad0a2f843914633f4996e2d61301abf16cdd2e477b6dd6a" => :el_capitan
    sha256 "3593d47b6e84132c1d55391f31e14fa9bf5edcec8fc986e7c45d5f7715ce34ec" => :yosemite
    sha256 "7846282537c7f22b45ce50269ceb4cbf27010bc0e292f3b44006fc4460e8a3a3" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/xcache.so"
    write_config_file if build.with? "config-file"
  end
end
