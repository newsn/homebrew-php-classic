require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Memcache < AbstractPhp56Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "6bae57e0805b2f8ef20afca21983a5a0645bfabde97b2e3212f817b3650cc930" => :sierra
    sha256 "2e70ceedd21f4c477378f7ac66a4aeea9bdb61e9d75d52bf57637cba14157448" => :el_capitan
    sha256 "e03133d4f3f3fe26149be27504c886d7e037fae9840848b2344ff1056641d557" => :yosemite
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
