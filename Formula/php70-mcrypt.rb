require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 19

  bottle do
    sha256 "a13168b90956744e6cd5e44230dce8c32733c9e617fcd0aec504b9bdb6a1027c" => :high_sierra
    sha256 "c2e18147de3a6db62a53d9a6d61fa3075a85c81d9f299ac63625a44a53d7419b" => :sierra
    sha256 "018b6e919a86029e1e466b125aa68676c51ae6194f9dcc315f0bf894debd09ab" => :el_capitan
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
