require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Http < AbstractPhp55Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_6_0.tar.gz"
  sha256 "1ff7c8d9cbeae67837033ddff7032f4acdd0c7bda3e3f12a1ca80620d949a775"
  head "https://github.com/m6w6/ext-http.git"
  revision 1

  bottle do
    cellar :any
    sha256 "c668c28ddb6ec6875fb410924a8e26ce12ec828f8f91a51482607d542ce9653d" => :high_sierra
    sha256 "83606769ef5776e63e167866f856f1ca3666857f8fa601932ab8d6d69e1a93bd" => :sierra
    sha256 "68cd6ca5122b25ecc86f5d90e973f49585adf1d4dc07a2c773ab4148378875bf" => :el_capitan
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php55-raphf"
  depends_on "php55-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php55-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php55-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
