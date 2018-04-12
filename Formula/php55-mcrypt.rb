require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 11
    sha256 "5272ec139618d7250e8ffbeedcc6bfcfc9974796cdc2d27bb2deba1db663f104" => :sierra
    sha256 "474163d5bc86a16864f965e9990d878dd1b4b8342d881a09e948be56e01eb645" => :el_capitan
    sha256 "06c363f926334876551dce0c9878e4df37cb21f2c21a63cc11afa4d91a0ec56a" => :yosemite
  end

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
