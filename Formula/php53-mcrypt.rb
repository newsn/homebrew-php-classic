require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mcrypt < AbstractPhp53Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    rebuild 1
    sha256 "c6f862cbbacc136ad2c396b8e0a683ab64f3dd79d077255ca7bb8733cb6c3308" => :sierra
    sha256 "ec4211ec8b1a58277ee0e4ea1027b8c26e6cff8705b4d4388d4cd2201d3593f8" => :el_capitan
    sha256 "433d37067dadee3f00b163d4d98fcf5d80861e8f10ce81784bbbd51a897aaa96" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
