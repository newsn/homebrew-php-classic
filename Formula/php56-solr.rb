require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Solr < AbstractPhp56Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ddd89617c605d998f49d4e0401ac2e97b5d8b8c3949358c47fcd3c82e4abd30" => :el_capitan
    sha256 "83dbb1dd6105fde1f28593407e68baeddbd840f8cb7bdf6e269a0932bbe61f99" => :yosemite
    sha256 "8b7559f9698f10557eadfc964c5ee2ddd72ee7d03b369800db1930b9ebab957c" => :mavericks
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
