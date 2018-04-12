require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Leveldb < AbstractPhp53Extension
  init
  desc "This extension is a PHP binding for Google LevelDB"
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "46ae51ccfef9df87a6059fd95c2e0490f00e46840f9010d83fc32014c151ae2f" => :el_capitan
    sha256 "242ab10a8766598aac9303065cd4307a882bee5e7f5d46476191ae0b4720eed2" => :yosemite
    sha256 "e821470ac8c3ba01f5cfa972de4c5d1844c7a5323d5c70b1ca3546d689b64ca4" => :mavericks
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
