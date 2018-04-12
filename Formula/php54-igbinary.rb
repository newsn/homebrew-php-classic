require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Igbinary < AbstractPhp54Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "160322b1831b9f55af046af273ece3ace81a1b1741ec7ea8415c0a046acd3327" => :high_sierra
    sha256 "eba98b120a9439f62248dc50e7ab4ea19b761fa9ad8a7bbe55e40a0fb8d4536b" => :sierra
    sha256 "082e7040929d1b12c40af65921babf34bee84f6645d8797fa434c473b21d22bb" => :el_capitan
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
