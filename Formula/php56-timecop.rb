require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timecop < AbstractPhp56Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e833777856253d43c60982ec0a595ebb9095fe6a603dcad6fe9a7df7e7a39f79" => :high_sierra
    sha256 "923d2bedf057e23856adec4a902979e9535a1808fb5c1080b040360a51ecc2f3" => :sierra
    sha256 "ca4ca17547dcf376e323f79b3163bf970f26f168a423b5023560194ca529bc89" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
