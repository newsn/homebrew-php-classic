require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.4.tgz"
  sha256 "90af2271485ab6c9a2bc0f1ceac7d0e3a0165fb0b5a7aa73531990219b180cad"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "125f75ad82e41f0f476a14419872368e518f551cb15adf8c6ea0d0cf0a7b1149" => :sierra
    sha256 "f438087ebea01b7ff6ecf2f19ae87cfa9de20eda683749d38a580a11b492c3f6" => :el_capitan
    sha256 "97711ddbb824615d869377abdb9cf6a87f80ef49a00489efa0546ee733ede97d" => :yosemite
  end

  depends_on "php54-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
