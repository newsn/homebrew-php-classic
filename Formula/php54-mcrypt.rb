require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    rebuild 3
    sha256 "aeef601491b736e80621c0fe01d54f2e86e3707c36b106cf36163e72315c83f0" => :sierra
    sha256 "f39c66e0813dc8170a26dcca69ee7ca381b7a9d1b78e1a79cc079566fe1360b1" => :el_capitan
    sha256 "71322c7f5ccf72cc7b908ac642d88595d99ef9a6902ec46cd9cfb747176c468f" => :yosemite
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
