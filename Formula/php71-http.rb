require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Http < AbstractPhp71Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"
  revision 1

  bottle do
    sha256 "87b287c4da084c137c4a9534b568d0bd6d91afa02025371ad1082078b75a1f06" => :high_sierra
    sha256 "0cb8bbcbc8311a3ec8fc34d7d24c7d0d4f47ffede17cac30af11c2468d59de52" => :sierra
    sha256 "5692d1b3ff22205fce34bdbf398af41d9ba5e472a8dd176cca43a48d648596c1" => :el_capitan
  end

  depends_on "php71-raphf"
  depends_on "php71-propro"
  depends_on "libevent" => :optional
  depends_on "icu4c" => :optional

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php71-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php71-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php71-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"
    cp "#{Formula["php71-propro"].opt_prefix}/include/php_propro_api.h", "ext/propro/php_propro_api.h"

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-http-libcurl-dir"
    args << "--with-http-zlib-dir"
    args << "--with-http-libevent-dir=#{Formula["libevent"].opt_prefix}" if build.with? "libevent"
    args << "--with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}" if build.with? "icu4c"

    system "./configure", *args
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"

    # remove old configuration file
    rm_f config_scandir_path / "ext-http.ini"
  end
end
