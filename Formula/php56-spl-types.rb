require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56SplTypes < AbstractPhp56Extension
  init
  desc "SPL Types is a collection of special typehandling classes."
  homepage "https://pecl.php.net/package/SPL_Types"
  url "https://pecl.php.net/get/SPL_Types-0.4.0.tgz"
  sha256 "b44101401b2664822fd17e6f491d912203496108ff9d0b86b043bff67c5f724f"

  bottle do
    cellar :any_skip_relocation
    sha256 "cf2bb93f9127307c508ef7e1a7d272f07934bebce8b9c0c38e6e267796007101" => :el_capitan
    sha256 "1790ad40c399eb8a512968c5997e7b144b71789a45f314afb291dd8358dac596" => :yosemite
    sha256 "a76cb8a643a7dffc24cd37fbb143ddd46aa43de6a99ba6a97384177fc879bd78" => :mavericks
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
