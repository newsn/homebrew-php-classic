require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Event < AbstractPhp55Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "9c0c15eb3002bb33fdbff85972a511066fdc7133cfabb0eddd509be87b75a29f" => :sierra
    sha256 "410d29689bbb35f8f3cd3dfe6187f6c610f594b2e11895afb02f8c9ec3a3cc38" => :el_capitan
    sha256 "6feb888ccd17c81d36a6f737d90bcb022b95a300907dacb18784f6ecaf10aef6" => :yosemite
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
