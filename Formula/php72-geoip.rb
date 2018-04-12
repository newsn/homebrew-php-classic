require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Geoip < AbstractPhp72Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    rebuild 1
    sha256 "89b204722563b08a8d5dc3411552667de3d70fdbc69ece525263891668a4b0d0" => :high_sierra
    sha256 "bdc03ebb7cb3dfb395e0592acf77a9f563cf06d5b5105556ae5863e7a0c87caa" => :sierra
    sha256 "5071abaa1cd4dd0921601f0a54a0bf7c194e513d564dfb6178629b15ecdd688d" => :el_capitan
  end

  depends_on "geoip"

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula["geoip"].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
