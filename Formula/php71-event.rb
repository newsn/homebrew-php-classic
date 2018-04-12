require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Event < AbstractPhp71Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "27fdacc2f300d37bdaf688fea87412d051e3b850d8d24a209fda905221b6b47b" => :sierra
    sha256 "6c339e77794fee27df64383751e244dac3146d40dc174317a70149d7a072d160" => :el_capitan
    sha256 "83a6c7f99f0b5c9da915d27bc9c5680c6ed52efb8e35e4d4980c4216d592f6e4" => :yosemite
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
