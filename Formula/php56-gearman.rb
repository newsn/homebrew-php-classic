require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gearman < AbstractPhp56Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    rebuild 1
    sha256 "3b91d773978e6b43031c89a11f3e7f1f0eecb5462582e77d0b16b312e41e79f8" => :el_capitan
    sha256 "b383cc1cf3a6ff793089f6e12fc6388b873590bd5693d87e93e05bb53338bd77" => :yosemite
    sha256 "c56d88eaae19455b00a5a071ea3e3d8622d7f747968d7875a82a71c75bb74de0" => :mavericks
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
