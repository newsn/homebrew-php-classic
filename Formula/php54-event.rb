require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Event < AbstractPhp54Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "2de53761c0f5514eb628af6df54ef2bf22d238aecf3ffebde7e25d3a0e5321f1" => :sierra
    sha256 "187bc867f2057c33dc6de6153545843bd5f25cbc5affbfbb4dab969d8d638153" => :el_capitan
    sha256 "be24eb361266cdea12fada4bed9a8180da5bc272b651e1165834812a02126bef" => :yosemite
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
