require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Zmq < AbstractPhp55Extension
  init
  desc "ZeroMQ for PHP"
  homepage "http://php.zero.mq/"
  url "https://github.com/mkoppanen/php-zmq/archive/1.1.2.tar.gz"
  sha256 "2ae77e90e0ed8112b11e838d6303940bbcae39e8d37683632a299db881bdb217"
  head "https://github.com/mkoppanen/php-zmq.git"

  bottle do
    sha256 "1dd8485ad3be607372e835544ccbc6e7814b11ad82b710da4409400dccdd5e77" => :el_capitan
    sha256 "e14cbb249de1d7f798231f661f96dc202905797d11c2b2c1672210f13f57e4b4" => :yosemite
    sha256 "29e712369fe62313eb773e99849e892549d3ffe8ca4fe4393adbbbb9c7f1961d" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "zeromq"

  def install
    ENV.universal_binary if build.universal?

    inreplace "package.xml", "@PACKAGE_VERSION@", version
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/zmq.so"
    write_config_file if build.with? "config-file"
  end
end
