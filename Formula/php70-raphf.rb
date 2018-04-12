require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Raphf < AbstractPhp70Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-2.0.0.tar.gz"
  sha256 "eb4356e13769bf76efc27bce4ad54f508701bcdac3c255dd1c8eb1e87fccb9fa"
  head "https://github.com/m6w6/ext-raphf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d8a093d9f05560b2f3d2b20aec76e8c8fe8b8e56856af2b2899b56c8a4c88fa8" => :sierra
    sha256 "4966719a7971781b7f50c468b271e657ab5bb14988f0f6494ee182c990cf3815" => :el_capitan
    sha256 "7041d87ee38380b22557d7d6c87a94f9c666cdde31b09d3864acdd42042ee909" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[php_raphf.h src/php_raphf_api.h]
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
