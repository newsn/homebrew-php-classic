require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gearman < AbstractPhp53Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    rebuild 1
    sha256 "5bbd24ecccf8562ead3466f6b6e805edde67556d9103d7c3d5b780dd30c17033" => :el_capitan
    sha256 "f7e6ffe21e8ab19e934517831a75d0465bc400ee86ab602fc79c93d6e79cc3c8" => :yosemite
    sha256 "efc9155d55064834a0673d959952c420b068279abfc4c348fb862d4ee74bc7eb" => :mavericks
  end

  depends_on "gearman"

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
