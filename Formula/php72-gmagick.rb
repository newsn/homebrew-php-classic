require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmagick < AbstractPhp72Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.4RC1.tgz"
  sha256 "4ead19640bebebfa68be41dc0097a93a7bf9beb56ea82b27343dba8ea4c5ecfa"

  bottle do
    rebuild 1
    sha256 "823464f46e708fe6f68790819f8dac25ca9fa08bfbca4366d53f14f26598ce35" => :high_sierra
    sha256 "86283673787d48904ab82e20b211760750204a526b03ef343215260f9e6655b3" => :sierra
    sha256 "7304bfe478907815243da352ff34b0ff368d4c4cf559b00aa567971ed5614cbc" => :el_capitan
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

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
