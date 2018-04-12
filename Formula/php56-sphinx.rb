require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sphinx < AbstractPhp56Extension
  init
  desc "Client extension for Sphinx - opensource SQL full-text search engine"
  homepage "https://pecl.php.net/package/sphinx"
  url "https://pecl.php.net/get/sphinx-1.3.2.tgz"
  sha256 "0c3ada36833a44a8147d2dd1b907548010ae53de0a05041a77e68dee036130e6"

  bottle do
    sha256 "f2e7a31105f8c6d5af9a547ac13b4ac4f2cb61fbf1a7adf3e2aa6acc32b0e1f1" => :yosemite
    sha256 "1142c54f1d52a496c4284773f12b2fe9aa73effa59d7d89a2b3649b13e7e3521" => :mavericks
    sha256 "35d8fd6dfd8eec9e6e558715c21550b747bf85511b9fb5bf55af54d99333488c" => :mountain_lion
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
