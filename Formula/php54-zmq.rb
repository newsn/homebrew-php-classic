require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Zmq < AbstractPhp54Extension
  init
  desc "ZeroMQ for PHP"
  homepage "http://php.zero.mq/"
  url "https://github.com/mkoppanen/php-zmq/archive/1.1.2.tar.gz"
  sha256 "2ae77e90e0ed8112b11e838d6303940bbcae39e8d37683632a299db881bdb217"
  head "https://github.com/mkoppanen/php-zmq.git"

  bottle do
    sha256 "30edea88c05a521ab749c9b3a203c6298371434f0625ae38825c6ed9c290c7e3" => :el_capitan
    sha256 "4c3cfd52f0d702e8b76636d4a34d9ef2c1c2dbbf7dc293933040b7b81c7a8895" => :yosemite
    sha256 "b1d48c328b120a64deafc0e38390798c4f43ee2f58b7ab534ba49eb973a5d268" => :mavericks
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
