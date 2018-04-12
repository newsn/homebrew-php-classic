require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gmagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    rebuild 1
    sha256 "6889f8c7b0b3e24ab4cdd42d12cde28303ec7fc6aa849326d3bdadbaf3a4fd61" => :el_capitan
    sha256 "631252fe89e421e9f5b55ce2746fbe17078f9e761bed43cc2ce76148642bdaa1" => :yosemite
    sha256 "afa2a334366ce68db8844119b6cf5b943ba971803a95ec0d88bfc3629b7839ab" => :mavericks
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
