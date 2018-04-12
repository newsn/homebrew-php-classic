require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 4
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "b472aaea08281b153bfab7c5ba382a293736f808881aae7483bb33a93ff7882c" => :sierra
    sha256 "20539c2e732b472e20b70a891efb36dbd13c194f2538a3bd990a5fb7e51f4337" => :el_capitan
    sha256 "dda6537806133158f663dbce0ed365b76943f86bc9780e936eeae70b6975067a" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "imagemagick@6"
  depends_on "php53-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV["PHP_IMAGICK"] = Formula["imagemagick@6"].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
