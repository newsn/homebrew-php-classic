require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 18

  bottle do
    sha256 "c4cc3d644f87e79c029fb41b35f6c52483ec827f0e5d53712c14f9b993b3b50d" => :high_sierra
    sha256 "53c2d4b7367d8aad38fe61602a2aee51e8f86a27c58240393bdc9e5da6f5e449" => :sierra
    sha256 "6ae6ec6b6a017a709555c1469bc0e1dd64641d18a2979e9cdc54a5d0fb477d60" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
