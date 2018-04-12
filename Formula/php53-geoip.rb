require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Geoip < AbstractPhp53Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "2f245acc20f823e7fe1fb8a582547d801275b2804759d8a2cde4331ee3bc0a67" => :el_capitan
    sha256 "57b2585f83fdf22d015f6472faf470d4620a960949a52fadbcd4c9d10c2fc330" => :yosemite
    sha256 "f6b5c29524b5ce65c9827728610d7941b33b08176716b398e6f9952b6dca5971" => :mavericks
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
