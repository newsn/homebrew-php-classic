require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Raphf < AbstractPhp71Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-2.0.0.tar.gz"
  sha256 "eb4356e13769bf76efc27bce4ad54f508701bcdac3c255dd1c8eb1e87fccb9fa"
  head "https://github.com/m6w6/ext-raphf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3cfc388aa195987bba0a8c31be087eb7c1af3e9f4fa451a9ee546d4faa8b7dbc" => :sierra
    sha256 "0c7e379613d9ace8bd27c048e37e72c1c43b8ab5ce8bab75a4e14f886e96a2c2" => :el_capitan
    sha256 "872c541820ba85209891c42973c297ef561bc37325b24c757559d4fae1d6e05d" => :yosemite
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
