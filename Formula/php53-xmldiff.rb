require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xmldiff < AbstractPhp53Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-0.9.2.tgz"
  sha256 "60d7d7fde2ebb695ae2cb26803153ad07a6146e0d70c102b3403131c86177550"

  bottle do
    cellar :any_skip_relocation
    sha256 "bb8af062cafc710659e04599027c830c89ed9948a711fe1990ac1bc72b4b53a3" => :el_capitan
    sha256 "88b6b49138f115ad007caa8ac32e1884530e92a5564b4cb035da3410a1bca2e7" => :yosemite
    sha256 "dad7a5caf16dfc70331dc845f8ba9fc46af352213b0df0347b44f604b8bce8f5" => :mavericks
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
