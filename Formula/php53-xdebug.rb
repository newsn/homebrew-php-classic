require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xdebug < AbstractPhp53Extension
  init
  desc "PHP extension which provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.2.7.tgz"
  sha256 "4fce7fc794ccbb1dd0b961191cd0323516e216502fe7209b03711fc621642245"
  head "https://github.com/xdebug/xdebug.git"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
