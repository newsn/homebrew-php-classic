require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Leveldb < AbstractPhp54Extension
  init
  desc "This extension is a PHP binding for Google LevelDB"
  homepage "https://pecl.php.net/package/leveldb"
  url "https://pecl.php.net/get/leveldb-0.1.4.tgz"
  sha256 "b0d2485e7f1353a794cd58bbaf331154723cda98ae41757f1167e1661bd78eef"
  head "https://github.com/reeze/php-leveldb.git"

  bottle do
    cellar :any
    rebuild 1
    sha256 "dd70ac7e579f7248fab863f537064ffc3c87527c2d2e8d66c1ff1420cb16811b" => :el_capitan
    sha256 "7b44c1c98672fdac277e2620a11fac4d1349b71d3176b7600fa0c54e362a2d59" => :yosemite
    sha256 "4fe8eaec43f1071b4274cbf03917c02618d45595d36aeafc2b90d80175c13d16" => :mavericks
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
