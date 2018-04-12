require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.3.tgz"
  sha256 "98c0d7acf6dd1b3930c25f8902decc98a334891736e460124557065e720d7a96"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "99c5725576c69381500252cf513931e2487c55b6f3bb150d4ca136730914d425" => :high_sierra
    sha256 "356c707e3b070707eb9b60cfc71ee6034db8705fe422c280d874fade31ad0202" => :sierra
    sha256 "20a2e4ee73f05a39be79c67e960478f3a1c2b81289f95634efef14b44994804f" => :el_capitan
  end

  depends_on "php71-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php7" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
