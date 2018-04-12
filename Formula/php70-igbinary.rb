require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Igbinary < AbstractPhp70Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ef851cf963b46703e717decc5667ee1ae69c938208674e9403752f7f727d97a0" => :high_sierra
    sha256 "4eab99590df631a4427ee50c7c1d6bda4c416fe460f9fb22cc01472c0fad0c88" => :sierra
    sha256 "b54434cc57f478b94b6ccb6f30932723e9f713811dab5ced81ef41b0d073200b" => :el_capitan
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
