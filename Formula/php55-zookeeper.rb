require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Zookeeper < AbstractPhp55Extension
  init
  desc "PHP extension for interfacing with Apache ZooKeeper"
  homepage "https://pecl.php.net/package/zookeeper"
  url "https://pecl.php.net/get/zookeeper-0.2.2.tgz"
  sha256 "ce657910472b0880e2f9dd0c73558a94a15c2cfc0208ba305dcc02e27cb34f78"
  head "https://github.com/andreiz/php-zookeeper.git"

  bottle do
    sha256 "64d937669ce9db6f27dab763b6fae85948797777b80102b1b016fae4fadeb92d" => :el_capitan
    sha256 "f8859ebcd7b37ce3f36f611cd680af4ca7e2eed926c96e7545fce1d6daf0939e" => :yosemite
    sha256 "245072877a9f96f6f49a1e1bff8db431d81e8262b4095bb4780a66a7de6c1559" => :mavericks
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
