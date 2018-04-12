require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zmq < AbstractPhp56Extension
  init
  desc "ZeroMQ for PHP"
  homepage "http://php.zero.mq/"
  url "https://github.com/mkoppanen/php-zmq/archive/1.1.2.tar.gz"
  sha256 "2ae77e90e0ed8112b11e838d6303940bbcae39e8d37683632a299db881bdb217"
  head "https://github.com/mkoppanen/php-zmq.git"

  bottle do
    sha256 "9e97aaaa41157170cb8fd2d93cf7aa764fec45e2b048f3bb93739263abe53370" => :el_capitan
    sha256 "bdb34f6f8688c97009cbf0835268d579bba329d04a594610fdc9b6cec44b17e6" => :yosemite
    sha256 "f2686fff07dca96bbb5ce698c9014f10bed84be265d871c35359fc593a3ef137" => :mavericks
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
