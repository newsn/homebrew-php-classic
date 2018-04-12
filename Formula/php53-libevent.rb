require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libevent < AbstractPhp53Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    rebuild 1
    sha256 "49ce22ff644b0199024af18291cfe60f7b4773f28ad6a0cf13418ecb9e325aab" => :el_capitan
    sha256 "02281279d8929af409e45420e016ac91697181b00be0f2cdf934367a00ae378a" => :yosemite
    sha256 "c81fd777b3dca2be61f531b146dd8265c1825b80104ad87f7c0e3f56a3fa8e7c" => :mavericks
  end

  depends_on "libevent"

  def install
    Dir.chdir "libevent-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent=#{Formula["libevent"].opt_prefix}"
    system "make"
    prefix.install "modules/libevent.so"
    write_config_file if build.with? "config-file"
  end
end
