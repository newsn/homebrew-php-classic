require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geoip < AbstractPhp56Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "000da86311ba3ce39973e1d9cb13c66c6261aebe4f12561d3a6ec0719d658d83" => :el_capitan
    sha256 "724cfe4b8f681da10f03b1ea7f51e537e3dfacd9d4ec72191f20269816ab234c" => :yosemite
    sha256 "884fcd5b2ecaef1795978018eacf7572ff5932b2abd5905bb91c8a99a50d2603" => :mavericks
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
