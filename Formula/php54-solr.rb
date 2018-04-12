require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Solr < AbstractPhp54Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f08bc7989f09a88003e9728eb7af25c42da101d403edd7844dd27c28e1b8cf89" => :el_capitan
    sha256 "e3c44d009c5637ee1e3f8ecfa792079359d714cbfe7d51b43e6c8ecfcb7f70f8" => :yosemite
    sha256 "0a7a50619db6553a7ecb8925dd916cececcae9cb7323dd85d48661164dbfb10e" => :mavericks
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
