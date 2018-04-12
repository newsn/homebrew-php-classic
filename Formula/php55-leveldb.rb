require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Leveldb < AbstractPhp55Extension
  init
  desc "This extension is a PHP binding for Google LevelDB"
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "9a8d0287e70600fb5fb65080a3a4a7d0c3fc2e7139808e8b5f7c6a31317970d9" => :el_capitan
    sha256 "ec9aca57944c7671e83e5c8c1b1c0b27adff3ed59c2cf1f087f1fd670331158a" => :yosemite
    sha256 "ba2a9a1592bf5a5bff454f80e392e41f6c8f489bceb22191b7e0458dca275bfa" => :mavericks
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
