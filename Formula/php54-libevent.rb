require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libevent < AbstractPhp54Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    rebuild 1
    sha256 "0d47d74bbd0bee4a76f36d44c5676086f79637fbf804f0ebccb351893c56be51" => :el_capitan
    sha256 "8784209ddca3637b690e606d937f15440f989c04b0a8c206f14e5a5321185d24" => :yosemite
    sha256 "14b551ad596a0c6d04dc7d2d84752ca3cfc0141c4d04a278f8fa72073bfb8d58" => :mavericks
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
