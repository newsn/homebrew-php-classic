require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Couchbase < AbstractPhp53Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.1.tgz"
  sha256 "d67c0fd19fdcaa72720d4910e29db12ccd72c30c4f441e5f1d9ef204fd7bc3d8"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "676b6b9f79db307a92f5608ff5f6e3028bdd20289438c242d92e57fb9e982c44" => :el_capitan
    sha256 "f0ab4d47512ddadafe43b13334daf4939bdad67693ca8727bf21884c1d3f6677" => :yosemite
    sha256 "0577a0bfa00cbc442ae0746b877aadfa0de6b7906c03a17b3a6e528b82af5155" => :mavericks
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
