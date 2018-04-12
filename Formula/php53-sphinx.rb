require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Sphinx < AbstractPhp53Extension
  init
  desc "Client extension for Sphinx - opensource SQL full-text search engine"
  homepage "https://pecl.php.net/package/sphinx"
  url "https://pecl.php.net/get/sphinx-1.3.2.tgz"
  sha256 "0c3ada36833a44a8147d2dd1b907548010ae53de0a05041a77e68dee036130e6"

  bottle do
    sha256 "ae08bf51b8eee9a382ea1b5d733bb68ccc8300d77e1315e3f2e4cd8f19fe76e1" => :yosemite
    sha256 "4769aa1e2e905eebdf6771e5cb00ef023a37fb97b7c67c5b176729b25fe073fc" => :mavericks
    sha256 "e067a22af0b48ea843a8adbaea5805f8fc00b73ba113aec9d152e1a6ea690671" => :mountain_lion
  end

  depends_on "libsphinxclient"

  def install
    Dir.chdir "sphinx-#{version}"

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/sphinx.so"
    write_config_file if build.with? "config-file"
  end
end
