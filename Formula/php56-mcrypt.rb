require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 7

  bottle do
    sha256 "5d1289ec2098d8e88852a9839884963d676f0207dbfd17cf519102864bd6d4e4" => :high_sierra
    sha256 "4ad7eea002e99eabf05e38207bc60101456a6d29444e67b29c34694237b92e60" => :sierra
    sha256 "8227fe94d6b0586f9f8979c3590b8dc6b007fe4f76d2e2846e04f779ac1d769c" => :el_capitan
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
