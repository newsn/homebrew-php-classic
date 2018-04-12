require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 20

  bottle do
    sha256 "49bb0b04b8c11d8146df38c0e290d99635580fbfe608f9a92b8b63a83db97ebe" => :high_sierra
    sha256 "df9634888271664547822adcf27d51b5260cc28656698296cbf513b6289d1877" => :sierra
    sha256 "16ae76143705c3cb0abcdafa0f8c629141043291118f0fdeceede114c447cc0b" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
