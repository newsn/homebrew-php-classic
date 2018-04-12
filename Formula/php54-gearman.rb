require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gearman < AbstractPhp54Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    rebuild 1
    sha256 "6034ba46dd864cf87e6ee135258d2e9b41f798015001d3f48257412d0e045c34" => :el_capitan
    sha256 "900d7fe22517c3e594ede4d00ab57ca1608a4f4c3b3cee7cdb66a4a76b1c2ec9" => :yosemite
    sha256 "70b58b076fecedca9249363d3e48e7f303e3eb6e8f778a3bc8d37347afc7ebd5" => :mavericks
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
