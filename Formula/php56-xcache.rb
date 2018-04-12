require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xcache < AbstractPhp56Extension
  init
  desc "XCache is a fast, stable ​PHP opcode cacher."
  homepage "http://xcache.lighttpd.net"
  url "http://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.bz2"
  sha256 "7d12a3cbd5f729b70f9226ac19406d11219f1c5f5e82b3bbb43ea9460cbf6cbd"

  bottle do
    cellar :any_skip_relocation
    sha256 "ab91488c5b88b0c5e5db1e5a7a24586222d6f45525c898b15c19f83df8181ed3" => :el_capitan
    sha256 "b74ea9800c62d629ce6dccfe51b3043bc089ad3789b4ddea4c5375e5e4e9664c" => :yosemite
    sha256 "c1b2e15f8aeba20a9de494b080195e8676b57d725347353adfc8f34dfb826ab3" => :mavericks
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
