require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Igbinary < AbstractPhp53Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "efd1c7757f1846e4ee8fd64e76e36aacdb741682172602dd07a8b5acc837b8dd" => :sierra
    sha256 "740fd46ee68ba58dbb5d0c593176b84743d526d73a95147bd4b5132242b5b9d4" => :el_capitan
    sha256 "a2029acd79ff1ad5107060e63cbb52cb9180eaf89745e26b94efb2795c45f705" => :yosemite
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
