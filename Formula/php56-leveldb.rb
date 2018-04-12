require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Leveldb < AbstractPhp56Extension
  init
  desc "This extension is a PHP binding for Google LevelDB"
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "43f991d3ab517285e779d8f5f217a62fbec18c94550a05ae0a36a69b077a9b1f" => :el_capitan
    sha256 "a6425c50d69ab0b54352ae670d07075e0722e1fb7e3872c142048c83acd95ba3" => :yosemite
    sha256 "e9bf1bb6b9d0dfc73d6238d685ce4b11c8498198c2f1bb97a04b38fdb3a61516" => :mavericks
  end

  depends_on "leveldb"

  def install
    Dir.chdir "leveldb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-leveldb=#{Formula["leveldb"].opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/leveldb.so"
    write_config_file if build.with? "config-file"
  end
end
