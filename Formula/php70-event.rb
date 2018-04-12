require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Event < AbstractPhp70Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "7a031dc65dce5af6a6a6c0882b824961cadfcfe9f60dc7bc529f6ae05b83724c" => :sierra
    sha256 "290d798bc5df668cdb328936ed2d9911b832f0c58090b5a7feebc0a2f3ca8660" => :el_capitan
    sha256 "cdaf032b6c911586a9bc92fe561aeb2aa295c52e47bc9ad95b7e65b184e89237" => :yosemite
  end

  depends_on "libevent"
  depends_on "openssl"

  def install
    Dir.chdir "event-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

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
