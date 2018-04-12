require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Event < AbstractPhp72Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  revision 1

  bottle do
    sha256 "6375f97e1df7c9ee58079520d5361505eaac85f01da0611723378ada008f6849" => :sierra
    sha256 "92cead5570cf16941a037cc8ed0d28d6cbff99bba5e40399485449b9e3b0d997" => :el_capitan
    sha256 "0180e7d5596e4adbdb610f97536276498cb119e7fa08d7403c7fe56f6fdedc43" => :yosemite
  end

  depends_on "libevent"
  depends_on "openssl"

  def install
    Dir.chdir "event-#{version}" unless build.head?

    args = []
    args << "--with-event-core"
    args << "--with-event-extra"
    args << "--enable-event-debug"
    args << "--with-event-libevent-dir=#{Formula["libevent"].opt_prefix}"
    args << "--with-event-openssl"
    args << "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/event.so"
    write_config_file if build.with? "config-file"
  end
end
