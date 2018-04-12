require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Geoip < AbstractPhp71Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "cf4750fed2c134c794646d7b54d64f7622aa11254c9bf31a2cc5a336fc847eaa" => :el_capitan
    sha256 "f59f96780bd10b9d68e30f284ca258a16c730c223cc3fb3c1928e820329e6742" => :yosemite
    sha256 "78cd82bfe85b353b7f6fcd67bc485bc60e2e990d735a95dadbbacb6b349691b8" => :mavericks
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
