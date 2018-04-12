require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geoip < AbstractPhp55Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "fbaecf97faa348e72def2dbc44600d15f37d538be100f61c4f35d08cdc7553ac" => :el_capitan
    sha256 "b2ff64c24da4188a3b89f669a561850498dfabbbaf0758f87b0b6bb6443176aa" => :yosemite
    sha256 "2350bd4334b96c584e20b6d71346bd0a229645adb4bce268c49b8a1ec4b0d11e" => :mavericks
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
