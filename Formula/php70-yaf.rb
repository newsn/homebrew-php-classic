require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaf < AbstractPhp70Extension
  init
  desc "PHP framework similar to zend framework built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://github.com/laruence/yaf/archive/yaf-3.0.3.tar.gz"
  sha256 "6761e636d055ec6756759185e91cf9fd42ca3f59e36172d7773b8052a1fb4887"
  head "https://github.com/laruence/yaf.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "dbff056ebe7ed0c310c47f846f8e0b2c8143328438543a4735a4d25874f1cc2e" => :el_capitan
    sha256 "fe35c10c356116478bec864ea54f2f92015747598bcf9066f9b2e7b4f8ef5275" => :yosemite
    sha256 "2c3d4bf25fcc52a8775434886bae778822a5291e900a39c1ceae877e18fe1dc2" => :mavericks
  end

  depends_on "pcre"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
