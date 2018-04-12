require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Memcache < AbstractPhp55Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "06c92cd54a303b724d40e9b0e87751d5235d7f40d961ea698d1d6e37f1605890" => :sierra
    sha256 "cf005cb56b410ba0b8d9048b942cac29b056bb2d84602c282663a87815b6fde7" => :el_capitan
    sha256 "8b33c28f1f53d48bbed51cddf5e71f4ae40496b08dfb51aa44c5ff1fd25b486a" => :yosemite
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
