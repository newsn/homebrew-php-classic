require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 5
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "582050bcb57e06ed4b334a2e132728ac57b3a304ac54ea659205df2a9adf18b7" => :high_sierra
    sha256 "b149fa4c0709154e75793a0fae7806273ebd203e6630d0a074e174f13e7b35dd" => :sierra
    sha256 "c956cd8eac881484bc594f906624bce6157785ad77a149d73cbf8bc6527130f8" => :el_capitan
  end

  depends_on "libdmtx"
  depends_on "php55-imagick"
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
