require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xmldiff < AbstractPhp55Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-0.9.2.tgz"
  sha256 "60d7d7fde2ebb695ae2cb26803153ad07a6146e0d70c102b3403131c86177550"

  bottle do
    cellar :any_skip_relocation
    sha256 "e90e1ec91dbfd8b2e7eebf7b7c7710dbddd345cada93bb4ad2d793d00999cb01" => :el_capitan
    sha256 "f68a60ea41527962cb98ce9676a4d5b0ae5d906773acd294ef69f616362b6d6c" => :yosemite
    sha256 "0060404a3f9f5b785ab90c3e073b84b4c80d029c3e91573466019ebfec41400d" => :mavericks
  end

  def install
    Dir.chdir "xmldiff-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
