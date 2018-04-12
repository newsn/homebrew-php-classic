require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Raphf < AbstractPhp72Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-2.0.0.tar.gz"
  sha256 "eb4356e13769bf76efc27bce4ad54f508701bcdac3c255dd1c8eb1e87fccb9fa"
  head "https://github.com/m6w6/ext-raphf.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "54fc96a8ac74f55a465f41c4993382178dc119dea80d5315d2353a505f4e1cc9" => :sierra
    sha256 "40515e955d574fe80ccefe0913216daef400b4f8032f2ed268ef58b367175b58" => :el_capitan
    sha256 "9cdb21ede6398c115dc3e1eb9e6291cc19e121f3514e20b3206f6908d665ce98" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[php_raphf.h src/php_raphf_api.h]
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
