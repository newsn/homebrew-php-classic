require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "63d9a7e5811903f06e532664b5b9df4a6df356fa8908b5ed104740ed598c5c59" => :high_sierra
    sha256 "f42d62523729e808977c42426b3332fe3d6bf62bb7c77cd43f06c8b80a0d1088" => :sierra
    sha256 "1d139a0bb0d44783e11aad598ecf0a7ac267fdddcba67e6ed03f5d3e20343625" => :el_capitan
  end

  depends_on "igbinary" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end
end
