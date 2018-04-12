require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Http < AbstractPhp54Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_6_0.tar.gz"
  sha256 "1ff7c8d9cbeae67837033ddff7032f4acdd0c7bda3e3f12a1ca80620d949a775"
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "d7f95930125fe953054177132f538dba8ca83b3c20d8e341ef8fcb7130e8d608" => :high_sierra
    sha256 "fbada51fb467a5fd2696d10bca02c62c2d609806ca5d35a7e8cdc01c78c1f545" => :sierra
    sha256 "6278cb208fb23f1d32f8704683a12443b85c1cd5737a1373d7f5c07e7307e1d9" => :el_capitan
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php54-raphf"
  depends_on "php54-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php54-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php54-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent-dir=#{Formula["libevent"].opt_prefix}",
                          "--with-curl-dir=#{Formula["curl"].opt_prefix}"
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"

    # remove old configuration file
    rm_f config_scandir_path / "ext-http.ini"
  end
end
