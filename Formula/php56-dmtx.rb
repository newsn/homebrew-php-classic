require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 5
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "a6c14f3a42d1e3df8ad48c88ba640296fc1cba19d954012ebe66e50fa585abfb" => :high_sierra
    sha256 "dab58da160ecd363a590910c4ecb87aec9b6174b25c4fc275be3b8ca3a4e72e0" => :sierra
    sha256 "2b482ef495475a718c1d7eaf36ea79185c14bc5cfcc227fcc301080566550f03" => :el_capitan
  end

  depends_on "libdmtx"
  depends_on "php56-imagick"
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
