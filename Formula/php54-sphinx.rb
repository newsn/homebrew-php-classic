require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Sphinx < AbstractPhp54Extension
  init
  desc "Client extension for Sphinx - opensource SQL full-text search engine"
  homepage "https://pecl.php.net/package/sphinx"
  url "https://pecl.php.net/get/sphinx-1.3.2.tgz"
  sha256 "0c3ada36833a44a8147d2dd1b907548010ae53de0a05041a77e68dee036130e6"

  bottle do
    sha256 "47ba289b1aa825d5f896c806ddf91bb6a2cbb2f6ee139c27ba9313f2bc42ec59" => :yosemite
    sha256 "8fc6bc13eb8e09d6fd0c1a9f0d631c5d9348dea09d5234eaf1ca33297589b48b" => :mavericks
    sha256 "8aab4870532f56ab82e193bc74c8432a1c7495b66163ef165e41a10bb2d1bfb1" => :mountain_lion
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
