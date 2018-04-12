require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Raphf < AbstractPhp53Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"

  bottle do
    cellar :any_skip_relocation
    sha256 "e8f66aaae9dc9fd64a84b24833ff67e80d7ea301053562c42f2f2c344eab4a73" => :el_capitan
    sha256 "f43a1ba3bc706caf1a7d83aa77c1ad07261d8704231303eefc7230cc730d3538" => :yosemite
    sha256 "e361b1db1ed9e4c212323f44218227cb35586ff736b30544e3c77e602277a3a1" => :mavericks
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
