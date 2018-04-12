require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Solr < AbstractPhp70Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "981999300a12cd4c4c34a28026ee52e6fd09959bb7b5f18d19e7a6556793dedd" => :el_capitan
    sha256 "31271bed95ebd9451377d41bc21b149d4062fe5b2a78cd0b1bf034d8cc0910e7" => :yosemite
    sha256 "98e7ccb885d9d144e7edb37dd4e6154e28de81b257031e8a6aafd853b893875f" => :mavericks
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
