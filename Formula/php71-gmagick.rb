require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.4RC1.tgz"
  sha256 "4ead19640bebebfa68be41dc0097a93a7bf9beb56ea82b27343dba8ea4c5ecfa"

  bottle do
    sha256 "8b4e2d1a006e3a8cc90430a92443fa0866e0002eacb5ac4912811b24c12991f4" => :el_capitan
    sha256 "a9a14c61ebd7396020c6b0805f311c53d68901cf311380107d9808ce8d3ea642" => :yosemite
    sha256 "70908cfb1bdab974c96ff5ee2c39b9a3ea753ff44c2a006a2aeabeb853681d74" => :mavericks
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula["graphicsmagick"].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end
