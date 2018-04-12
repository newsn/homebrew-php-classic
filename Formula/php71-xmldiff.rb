require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xmldiff < AbstractPhp71Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-1.1.2.tgz"
  sha256 "03b6c4831122e2d8cf97cb9890f8e2b6ac2106861c908d411025de6f07f7abb1"

  bottle do
    cellar :any_skip_relocation
    sha256 "9ff14eb9a44e34eb432ea564758035ac9357325835578c30d65d8c5ea47591e2" => :sierra
    sha256 "23fda2941b24b6586d7aa9138d298e996e849a4d7e791a35347b068a86ba1a12" => :el_capitan
    sha256 "c9a07487516b1a5701c05f253f2e8fb18ba900cc4b37328dbb7224358594f32b" => :yosemite
  end

  def install
    Dir.chdir "xmldiff-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
