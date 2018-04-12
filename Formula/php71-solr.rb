require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Solr < AbstractPhp71Extension
  init
  desc "Fast and lightweight library to communicate with Apache Solr servers"
  homepage "https://pecl.php.net/package/solr"
  url "https://pecl.php.net/get/solr-2.4.0.tgz"
  sha256 "22865dafb76fc5839e84a5bd423bb37d5062883e5dfc4d064b43129ac9f2752c"
  head "https://git.php.net/repository/pecl/search_engine/solr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c89a16c9ea98e9bf647daa946cb4b2094923b1cd9db52cda1552a7840aae77ce" => :el_capitan
    sha256 "051d9ff8e49f64c7b74407e21ee270b142c4d820db007313f659bc48d073fa26" => :yosemite
    sha256 "a410bf99c5cf05fe6723c8fa594d2955ef550e1d5d5e7bc061ac252ebcc4bf0e" => :mavericks
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
