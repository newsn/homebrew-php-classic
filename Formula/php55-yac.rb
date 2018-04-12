require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yac < AbstractPhp55Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-0.9.2.tar.gz"
  sha256 "d99023db0f73b0d3ba07b5ed1e9386182c5040202b1c2a4891e90df7b040afba"
  bottle do
    cellar :any_skip_relocation
    sha256 "9c9c7588eff6837a96a607315901cc1a3a62a41b140fc0b3648fadc22623ea92" => :sierra
    sha256 "e5c342e7986ba08ea5658e703cde0b2c346372a3e038cba21c04a7f061f56499" => :el_capitan
    sha256 "ca4e2689c18e7c6b5b1674cd4ef0f16970726b6410941666862181e2857aaf25" => :yosemite
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
