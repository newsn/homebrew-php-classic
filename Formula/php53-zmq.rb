require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Zmq < AbstractPhp53Extension
  init
  desc "ZeroMQ for PHP"
  homepage "http://php.zero.mq/"
  url "https://github.com/mkoppanen/php-zmq/archive/1.1.2.tar.gz"
  sha256 "2ae77e90e0ed8112b11e838d6303940bbcae39e8d37683632a299db881bdb217"
  head "https://github.com/mkoppanen/php-zmq.git"

  bottle do
    sha256 "9510b68aa91198e5024c58fbaaefc5a73ef7860a260b81cd741e536a0e55d9d0" => :el_capitan
    sha256 "44b5684c5a2a6b5acd6da0dbd3a9133f68d518495463d424ecde71bd9623c048" => :yosemite
    sha256 "f4ab61e3812126e7548203c056d53ca23b5f829b93052186aade2cd58e5f5ad4" => :mavericks
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
