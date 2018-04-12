require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Event < AbstractPhp56Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "97ce61d59f5643e8cc12daa4323d5aac3fb2b89305f29e1d5dcc2d74bb535c6e" => :sierra
    sha256 "f800eae362aba96f753e4c05819292566e4cf780dbbe4d11e8e82cc06c2eb0d2" => :el_capitan
    sha256 "ed9675c29b6090f2938cfeacebb48c96f87f0213011c9ea09458a189f45f6ffd" => :yosemite
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
