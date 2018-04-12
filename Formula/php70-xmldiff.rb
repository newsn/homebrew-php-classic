require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xmldiff < AbstractPhp70Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-1.1.2.tgz"
  sha256 "03b6c4831122e2d8cf97cb9890f8e2b6ac2106861c908d411025de6f07f7abb1"

  bottle do
    cellar :any_skip_relocation
    sha256 "01b490511cf183b800401ac5becb875b8e4a848ec424eb50306b26769fa7b5a6" => :sierra
    sha256 "cbe8276b48173f14d71310d10f92f952b9f9bd207e5d2d5c0580c8bfa7ac15d9" => :el_capitan
    sha256 "2ba80eb8903fe5f039a9a43f5a16d78246622301045343444a1e1a5b89008166" => :yosemite
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
