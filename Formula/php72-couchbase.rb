require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Couchbase < AbstractPhp72Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.3.tgz"
  sha256 "98c0d7acf6dd1b3930c25f8902decc98a334891736e460124557065e720d7a96"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "3163ef05181aec0dd3f6ff4712b04ec94150d42ef29210c9129060b3cbb544c2" => :high_sierra
    sha256 "394a4480dbaebf988a46da35855bd8f657537059a0f97cec76ee2a3339bd82c0" => :sierra
    sha256 "4a9915ad34a037417119fa8b0c5e32827b85aac00445781df5fca392199b729e" => :el_capitan
  end

  depends_on "php72-igbinary"
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
