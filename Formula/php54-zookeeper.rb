require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Zookeeper < AbstractPhp54Extension
  init
  desc "PHP extension for interfacing with Apache ZooKeeper"
  homepage "https://pecl.php.net/package/zookeeper"
  url "https://pecl.php.net/get/zookeeper-0.2.2.tgz"
  sha256 "ce657910472b0880e2f9dd0c73558a94a15c2cfc0208ba305dcc02e27cb34f78"
  head "https://github.com/andreiz/php-zookeeper.git"

  bottle do
    sha256 "36dc48d58ac477dcbf60231afa3c059004a9d908d375b05c7842ca9d157bb93a" => :el_capitan
    sha256 "75f0dde1234980472ac14884723494ee369d3203aaf28cb2291693211aec1e9b" => :yosemite
    sha256 "5b7a9d47976bfd0179e1a5dacd674860a968eddb994058ad3e6c0ebdc1b78521" => :mavericks
  end

  option "disable-session", "Disable zookeeper session handler support"
  depends_on "zookeeper"

  def install
    Dir.chdir "zookeeper-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libzookeeper-dir=#{Formula["zookeeper"].opt_prefix}"
    args << "--disable-zookeeper-session" if build.include? "disable-session"

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/zookeeper.so"
    write_config_file if build.with? "config-file"
  end
end
