require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yac < AbstractPhp53Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-0.9.2.tar.gz"
  sha256 "d99023db0f73b0d3ba07b5ed1e9386182c5040202b1c2a4891e90df7b040afba"
  bottle do
    cellar :any_skip_relocation
    sha256 "dac0bc5a77331815a45ebe3fa1150544184d7a6ba90b19d0b1ef8eb07b6fa114" => :sierra
    sha256 "01189df71f37190d71c205f6cccda4b89e7db58dd451ac6e715ece59de8fe5e1" => :el_capitan
    sha256 "f13b1f98c9887267244a00ea9ce308985380b3c7ece2e6f78da56a51613939cd" => :yosemite
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
