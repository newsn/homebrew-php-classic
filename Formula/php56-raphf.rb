require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Raphf < AbstractPhp56Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "5e223a6b112e96d77d2ddeb4ceaedaa13f23aad9ad462ed0be388d8c51699c8e" => :el_capitan
    sha256 "3711d064b263215eaaf10d4e10ee31d4797faaeab4484a11882029243fa2a3cc" => :yosemite
    sha256 "9e06905a1ad9871e2073ffdc9f3e9b1c6d0057a78cdeddfcb7688e79e551c6de" => :mavericks
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
