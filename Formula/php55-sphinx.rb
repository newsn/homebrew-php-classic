require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Sphinx < AbstractPhp55Extension
  init
  desc "Client extension for Sphinx - opensource SQL full-text search engine"
  homepage "https://pecl.php.net/package/sphinx"
  url "https://pecl.php.net/get/sphinx-1.3.2.tgz"
  sha256 "0c3ada36833a44a8147d2dd1b907548010ae53de0a05041a77e68dee036130e6"

  bottle do
    sha256 "e3af0b0c0ecce4be872737a08a438f9ccbf14f01e18b7b394dcde6da9e9ac8ac" => :yosemite
    sha256 "74ff310c977b7003fb4e5501c86102d028d01c9b37b077904cfccc985a946757" => :mavericks
    sha256 "cb9f328fca993808ca8c9eab2d3c208d368357bdeb3e21615b01b7235defb787" => :mountain_lion
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
