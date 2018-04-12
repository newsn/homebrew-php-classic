require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zmq < AbstractPhp71Extension
  init
  desc "ZeroMQ for PHP"
  homepage "http://zeromq.org/bindings:php"
  url "https://pecl.php.net/get/zmq-1.1.3.tgz"
  sha256 "c492375818bd51b355352798fb94f04d6828c6aeda41ba813849624af74144ce"
  head "https://github.com/mkoppanen/php-zmq.git"

  bottle do
    sha256 "68717202d5d143e221567372430ce0af8478604001ff2833006b6f183de2ce9a" => :sierra
    sha256 "f0d60d90ad6b419c0cece3b8fb22de68979d70de90e6b2e51af6261ea6ce29b8" => :el_capitan
    sha256 "208d152b8ee7e7124e02c9fcb78da5c05f3b2d8ec2a1189189ff6c302e8ea76c" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "zeromq"

  def install
    Dir.chdir "zmq-#{version}" unless build.head?

    if build.head?
      inreplace "package.xml", "@PACKAGE_VERSION@", version
      inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version
      inreplace "php_zmq.h", "@PACKAGE_VERSION@", version
    end

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/zmq.so"
    write_config_file if build.with? "config-file"
  end
end
