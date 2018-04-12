require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zookeeper < AbstractPhp56Extension
  init
  desc "PHP extension for interfacing with Apache ZooKeeper"
  homepage "https://pecl.php.net/package/zookeeper"
  url "https://pecl.php.net/get/zookeeper-0.2.2.tgz"
  sha256 "ce657910472b0880e2f9dd0c73558a94a15c2cfc0208ba305dcc02e27cb34f78"
  head "https://github.com/andreiz/php-zookeeper.git"

  bottle do
    sha256 "8882c1e52c6e16f476518873eeddfb7dd1ee9f15d3c9aac37fa081ac90ff5253" => :el_capitan
    sha256 "2e0d6f8508b424c39842559c3f096c275ce68c234712ab75952ef50e1ed6354c" => :yosemite
    sha256 "fa6860d7fb996a7278c7d0cab875704343c4d8435f2830c549ee059ace0e65ce" => :mavericks
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
