require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dmtx < AbstractPhp54Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 4
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "e408bcca5e185977f765d647b6f15870dcab1864f0a09dc07391f0d46ba95a82" => :sierra
    sha256 "209f91fd973e2acc3f4cda5d814f17ff395431f63909e68f12cb75d3357aaa4f" => :el_capitan
    sha256 "d4bd8d699c5d44e06df5ae89927be9f541d1168efe188e962ad9b0d3ae6bbab6" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php54-imagick"
  depends_on "pkg-config" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
