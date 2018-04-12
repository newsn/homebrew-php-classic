require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yac < AbstractPhp54Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-0.9.2.tar.gz"
  sha256 "d99023db0f73b0d3ba07b5ed1e9386182c5040202b1c2a4891e90df7b040afba"
  bottle do
    cellar :any_skip_relocation
    sha256 "60bf5ff45020b154198f6ca6cf58f482d1e41d7c78c3df2c9b42c58aec9e2b9a" => :sierra
    sha256 "51318f8c97fe8c059ce8f8468de46c3707fc05837b217821afe253c9051ae6e3" => :el_capitan
    sha256 "b7916359b31b4b2c710267d2e398232a28373b9f990ad034a5701f6d09c83ca4" => :yosemite
  end

  version_scheme 1
  head "https://github.com/laruence/yac/tree/php5"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
