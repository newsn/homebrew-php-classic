require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Stats < AbstractPhp70Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.1.tgz"
  sha256 "994da82975364773248091bb3f83cc5f101db70e88c79af8a60bea8ad054dd06"
  head "https://git.php.net/repository/pecl/math/stats.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "16455097c746c188ff5bef2aff08bbdd0be5feeaeea96666c6ea8211d32eeab5" => :el_capitan
    sha256 "ebb13a3a2b6d2f40be787a9dbf036dfeb2434ade35766da0ce7dbaf4b600446a" => :yosemite
    sha256 "78c981b9d3765a268669fca28592722fd880e9adc6f1143acb12785717cc7569" => :mavericks
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
