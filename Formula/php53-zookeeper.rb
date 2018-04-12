require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Zookeeper < AbstractPhp53Extension
  init
  desc "PHP extension for interfacing with Apache ZooKeeper"
  homepage "https://pecl.php.net/package/zookeeper"
  url "https://pecl.php.net/get/zookeeper-0.2.2.tgz"
  sha256 "ce657910472b0880e2f9dd0c73558a94a15c2cfc0208ba305dcc02e27cb34f78"
  head "https://github.com/andreiz/php-zookeeper.git"

  bottle do
    sha256 "0e98df0745eb3bd446cd6621a1808e6a85ef3d54657c4fbca27180813d71f8df" => :el_capitan
    sha256 "347c2be13b91b0b9377fd1aa56754d23c6656a5768a23e1c3f85cee919e4f142" => :yosemite
    sha256 "5668e38b448b771949b43f28e9103e078891b22cf008a6b8424172174b4fc89a" => :mavericks
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
