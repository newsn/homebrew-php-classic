require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.3.tgz"
  sha256 "98c0d7acf6dd1b3930c25f8902decc98a334891736e460124557065e720d7a96"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "0e8ff8ac5c91cd593b1a3860baf6790caa2da2f986011157afc9c6f60bb9a16a" => :high_sierra
    sha256 "b5bedf7298c05ac44e6aceba7857054b579174ea134cf83b891efcb964118023" => :sierra
    sha256 "98bf947f938ec98b2abfa3e0cc7d623a0e2589a4f4aa5dbc5790520f7151d837" => :el_capitan
  end

  depends_on "php56-igbinary"
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
