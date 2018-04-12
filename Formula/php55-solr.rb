require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Solr < AbstractPhp55Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9f8fe50f2b5db46c20d1fe0c6e98a5312c39524c13106e51d05aee70ecc32f0d" => :el_capitan
    sha256 "bbb7f7498cad8981cc84a7c224d730ee00f5895942d13c0ecd682a84bef9c025" => :yosemite
    sha256 "10dc54cacf0acdc91f1201c0bbd54f50ffcada8e351d547bb8fb0c15743e4310" => :mavericks
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
