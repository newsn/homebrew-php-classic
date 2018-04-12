require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Solr < AbstractPhp53Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "863bd1062d91ba7033cc7ee5fb8e97059e863f2e27b0f9da02b62db9e7ab22c1" => :el_capitan
    sha256 "343cecdbfbf141d23e62b5f42c06f9fc737eccbd69d719a2e3ce28bcb33e1ad9" => :yosemite
    sha256 "a83a955e72b07ceb1e5d48b302144e7846a29fc859e04a80ce3577252fee7fd5" => :mavericks
  end

  def install
    Dir.chdir "solr-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/solr.so"
    write_config_file if build.with? "config-file"
  end
end
