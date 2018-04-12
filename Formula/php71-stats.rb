require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Stats < AbstractPhp71Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.1.tgz"
  sha256 "994da82975364773248091bb3f83cc5f101db70e88c79af8a60bea8ad054dd06"
  head "https://git.php.net/repository/pecl/math/stats.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "11ac6733fa0f0b6b79dd4f88ae1e9ee5fbc93b3a7d3bbe4684a63734c98cab72" => :el_capitan
    sha256 "f3f4f2c02e5b247db5ea4231867fd7493da84c6dc7afc9c85feef1dda019732c" => :yosemite
    sha256 "ca3392b4668de01a582fb3c2febe43bb31e801f9e61d73aa7c2937f896e45c9b" => :mavericks
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
