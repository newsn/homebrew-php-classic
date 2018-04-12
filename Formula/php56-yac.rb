require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yac < AbstractPhp56Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-0.9.2.tar.gz"
  sha256 "d99023db0f73b0d3ba07b5ed1e9386182c5040202b1c2a4891e90df7b040afba"
  bottle do
    cellar :any_skip_relocation
    sha256 "cdeeb9dd6517b4366c96bc6eb8ce8632102dc960b96ec65f3e2dd4bd74960895" => :sierra
    sha256 "471ff346010794daed7682c98810789c942b8747b8f46e69f5a0d9e0461aad96" => :el_capitan
    sha256 "102f5e63e92d22d5fee1026666e2a548eff4bc5d198dcbc1ca10c7a1d74a69e9" => :yosemite
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
