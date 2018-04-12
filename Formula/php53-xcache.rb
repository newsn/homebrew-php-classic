require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xcache < AbstractPhp53Extension
  init
  desc "XCache is a fast, stable ​PHP opcode cacher."
  homepage "http://xcache.lighttpd.net"
  url "http://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.bz2"
  sha256 "7d12a3cbd5f729b70f9226ac19406d11219f1c5f5e82b3bbb43ea9460cbf6cbd"

  bottle do
    cellar :any_skip_relocation
    sha256 "22af3966abe0b06df2d1bf530ff072eaa8c5aaebcd0b9476fdbdba0665ba9e83" => :el_capitan
    sha256 "088f38a5bb77c70ea6bff4a28ce768d91dc8f872d8ada762f794c34ae6d93cf1" => :yosemite
    sha256 "0d62c73819bda4df37159c365ec9ba38104782416eaa0bbd19593af9f1919ea3" => :mavericks
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
