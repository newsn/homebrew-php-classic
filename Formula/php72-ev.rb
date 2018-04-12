require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ev < AbstractPhp72Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "bda067671ba9a207123c30e2983ac89f6b6fc582427ef90738a964ef3c3ae386" => :high_sierra
    sha256 "4febf514476a0d8073beb18c0d2ada2f8fb404b806603e2e16101758a1848f66" => :sierra
    sha256 "1367ee27660a7c29e3fbc1862f82a10d91590aa375a1947d1aa93ac7256955ec" => :el_capitan
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
