require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Http < AbstractPhp53Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"
  revision 1

  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "6a203d8c25ef6039039f5b08a563b663d8ba7a4f498b780bfeedfdf0b58d2964" => :sierra
    sha256 "7b6bd7c49f62ca0159f216e26193a93845ea7ec5143ce6433ac968cea470d652" => :el_capitan
    sha256 "ad567df265127ac82aeda0ad982ec47eb12edcf59687e976a932e8a6cd069735" => :yosemite
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php53-raphf"
  depends_on "php53-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php53-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php53-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
