require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gearman < AbstractPhp55Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    rebuild 1
    sha256 "7267a6aabf9f2d1531bb82d5ff8675b19f861f1f3d1a84777155fd4adf5a9fd8" => :el_capitan
    sha256 "0a6f888d344f6593621dd23e83aa072d6b1bc990b98de8c62f99a6ab659a9260" => :yosemite
    sha256 "3e6167d6481e14df7a77b13a6bf71068b0df9bc732a3326cbe607d72a4f9f00a" => :mavericks
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
