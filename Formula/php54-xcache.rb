require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xcache < AbstractPhp54Extension
  init
  desc "XCache is a fast, stable ​PHP opcode cacher."
  homepage "http://xcache.lighttpd.net"
  url "http://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.bz2"
  sha256 "7d12a3cbd5f729b70f9226ac19406d11219f1c5f5e82b3bbb43ea9460cbf6cbd"

  bottle do
    cellar :any_skip_relocation
    sha256 "101337b58127e5f3772342b46089a42d2327b0bc82c6c6d6ab0f09b5c4eb1138" => :el_capitan
    sha256 "49428079815e85fce22b18f0ed10d3442f61dd31c2856dae029199c4423af4bd" => :yosemite
    sha256 "37522cf39cf53ae4dadc3678aaab3c261d164a4592a0252a7668668c086866d4" => :mavericks
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
