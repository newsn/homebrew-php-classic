require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Lzf < AbstractPhp54Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.3.tgz"
  sha256 "42ec458ea10128a801e8d39736b519ba81fa75d2a617d2777b7d6b3276601a5d"
  head "http://svn.php.net/repository/pecl/lzf/trunk/"

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
