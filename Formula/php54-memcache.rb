require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Memcache < AbstractPhp54Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "df8e190fcbffd8c34226ea206a2b2868be7f37a2609d8d659728061077e7fd05" => :sierra
    sha256 "e6e5b2cf67f45824feeb5c28425513f0763db3e6113d5fb15c14e65b86247457" => :el_capitan
    sha256 "bacb9ce62f79979bbe65288415044da879ace48ba1cc4e784369a339055bab7a" => :yosemite
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
