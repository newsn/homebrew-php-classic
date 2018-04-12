require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Memcache < AbstractPhp53Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "2451c565561eabca139907fb5d30a07e4e5f9375b02670faee09f0126db35b8c" => :sierra
    sha256 "953ee4f685cfab9ed0c4d23b2233efa4de3caf123a4fcf44704d634b3bd81376" => :el_capitan
    sha256 "c996dd0e881c32a322d5cec2369402a4ab619f4d85e2b2c720791a550b11f6ae" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/memcache-3.0.8.tgz"
    sha256 "2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311"
  end

  def install
    Dir.chdir "memcache-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    ENV['CFLAGS'] = '-fgnu89-inline'
    ENV['LDFLAGS'] = '-fgnu89-inline'
    ENV['CXXFLAGS'] = '-fgnu89-inline'

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/memcache.so"
    write_config_file if build.with? "config-file"
  end
end
