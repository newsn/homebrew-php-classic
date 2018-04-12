require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gearman < AbstractPhp72Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz"
  sha256 "f71e8ff218f31e3b9a15534e18846b9f9526319daffcc12e76b545889e44e130"
  head "https://github.com/wcgallego/pecl-gearman.git"
  revision 1

  bottle do
    sha256 "d39b030371eb5a130bafb1d7ea66d2160a13cde955e950a8d921a27657f30b04" => :high_sierra
    sha256 "a90da773687b46f15460707733004cf798f56b0664fcc47badda84bbdd1ac6fb" => :sierra
    sha256 "91cbb60d3b1a865f65b3253bc9d8b000273a57422534a8558175e7e5d0764a67" => :el_capitan
  end

  depends_on "gearman"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
