require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Geoip < AbstractPhp70Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "284a72f6a09c300c1b7ff38c456303da3dd79a29aa7504e8efaf19444c0f7560" => :el_capitan
    sha256 "7c512c34be03bfe8a1554b6bfa62241f6d9d2e7e031008a7185fc349b9b9df99" => :yosemite
    sha256 "a9c985fcc5db04d88d5fae8129f74ffca1dd2d6a5cc6f5a68a59c4143a9132ce" => :mavericks
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
