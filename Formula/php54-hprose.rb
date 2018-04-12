require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Hprose < AbstractPhp54Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "e38caab68627eea281cfbb49265d86181279c94a96cf73e221288afb872d1ea4" => :high_sierra
    sha256 "b423079d9d39eccca5f50867939afcbf3a7c681781194031299f65e3916e94fa" => :sierra
    sha256 "da3cef02983da0823bf30411cd2b3911f3254568bc6af89922450e6c45c2a992" => :el_capitan
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
