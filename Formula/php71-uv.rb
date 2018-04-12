require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Uv < AbstractPhp71Extension
  init
  desc "interface to libuv library"
  homepage "https://github.com/bwoebi/php-uv"
  url "https://github.com/bwoebi/php-uv/archive/v0.1.1.tar.gz"
  sha256 "e576df44997a0b656deb4a1c2bfd1879fb3647419b0724bd6e87c7ddf997e2c1"
  head "https://github.com/bwoebi/php-uv.git"

  bottle do
    sha256 "3922148962f133176d463e2a1bf90fd1e57b90fb9e3585d9c17d2c504ab6ab0c" => :sierra
    sha256 "89e7b323eb34291f828b4e2d2b13149ed9963d63c00301abe5d4e9fcff5aabf1" => :el_capitan
    sha256 "d42eaabd27cd0527d307ffdcc3818ed86f91ed726b1288c17eaf9244ee38a370" => :yosemite
  end

  depends_on "libuv"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-uv=#{Formula["libuv"].opt_prefix}"
    system "make"
    prefix.install "modules/uv.so"
    write_config_file if build.with? "config-file"
  end
end
