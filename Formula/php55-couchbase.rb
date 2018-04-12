require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.4.tgz"
  sha256 "90af2271485ab6c9a2bc0f1ceac7d0e3a0165fb0b5a7aa73531990219b180cad"
  head "https://github.com/couchbase/php-couchbase.git"
  revision 1

  bottle do
    cellar :any
    sha256 "fd95b685bc9ea20c904b41103b311087a208c39f09bd051d31a95e6d2e6cc6ee" => :high_sierra
    sha256 "6c5a9bab2132cb27ac1f27c4a8d79494fb600aaa7aca00a08a6caf54d3d6e794" => :sierra
    sha256 "a104317376b31d630349bf27231ce990e4ef077c0f04af087e3c22021b8d4cfa" => :el_capitan
  end

  depends_on "php55-igbinary"
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
