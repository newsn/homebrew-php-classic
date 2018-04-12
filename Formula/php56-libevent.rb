require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libevent < AbstractPhp56Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    rebuild 1
    sha256 "1de355272c0e200a7a8f901164a58b581e61599bed7e6029360f7596008e20df" => :el_capitan
    sha256 "40b304da1a1f13e2de88a8e02452f8731f50198e33be87c3186073beed734325" => :yosemite
    sha256 "371b94a7f9b21b847062a72a2969617d1543bb77f94cb3808a5cc7c4dbfdfa51" => :mavericks
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
