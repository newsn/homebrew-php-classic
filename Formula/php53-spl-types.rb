require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53SplTypes < AbstractPhp53Extension
  init
  desc "SPL Types is a collection of special typehandling classes."
  homepage "https://pecl.php.net/package/SPL_Types"
  url "https://pecl.php.net/get/SPL_Types-0.4.0.tgz"
  sha256 "b44101401b2664822fd17e6f491d912203496108ff9d0b86b043bff67c5f724f"

  bottle do
    cellar :any_skip_relocation
    sha256 "5f155277aacc01d2697bae1c6ab237ca6d8886311b8b25ac0470a538a1e2b2cc" => :el_capitan
    sha256 "0083c9e510d9fcc82fa9197b01ed8a54ce1820bfde890aa3bbb861714812708c" => :yosemite
    sha256 "64966f9a45373fd0df194274166959f96dfccf4f7ec20f482c0159c484fe0626" => :mavericks
  end

  def install
    Dir.chdir "SPL_Types-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/spl_types.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "spl_types"
  end
end
