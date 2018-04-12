require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Raphf < AbstractPhp54Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"

  bottle do
    cellar :any_skip_relocation
    sha256 "75aca2f3ee04d19f57b03fdadf59f02966aa5154e9e198698a77dac73ac9ab6c" => :el_capitan
    sha256 "0695d843feda46a37b584e8dccf4ef142709f1eeb88d41b8e4bc3d1c5f4d0659" => :yosemite
    sha256 "9ead03b28b71580def65be5885f72c8344d85b9f2b8bbb34b5420aec05e6f6e8" => :mavericks
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
