require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geoip < AbstractPhp54Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "cb4ba858191706e4eaeeebd63567af48996cb55d25a00a30e7c65afabd15c20b" => :el_capitan
    sha256 "5f15e2f7a61a6ceae3af9c3c36912e35fb4623fe0a37169e4014e582fdda2d98" => :yosemite
    sha256 "4c7aebd2658fdaa3ad566512d421284e4207043bf59cb01028aca80bad0c1528" => :mavericks
  end

  depends_on "geoip"

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula["geoip"].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
