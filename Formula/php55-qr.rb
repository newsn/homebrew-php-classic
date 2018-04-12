require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Qr < AbstractPhp55Extension
  init
  desc "QR Code generator extension."
  homepage "http://pecl.opendogs.org/"
  url "http://pecl.opendogs.org/get/qr-0.4.0.tgz"
  sha256 "0d628741d77f34207a00cc0b84967ecf4ccb38f03e65105573ecfead8c76f114"

  bottle do
    cellar :any_skip_relocation
    rebuild 5
    sha256 "ec56d4e506753d843da4c4378569c9611561432105eb1cae5f8b3c16eefb2724" => :sierra
    sha256 "f47dab108b3921c27227ee78b4867a55ba36d5fb5f4cdf1fb4e29c4dc3c67e5f" => :el_capitan
    sha256 "1ba608eb98a9a72368e0e370e3cc44968a29926ed0546d7de6ec6eebc34012f4" => :yosemite
  end

  patch :DATA

  def install
    Dir.chdir "qr-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--enable-qr", "--enable-qr-gd", "--with-qr-tiff=/usr"
    phpconfig
    system "make"
    prefix.install "modules/qr.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
--- qr-0.4.0/qr-0.4.0/php_qr.c-org	2014-11-16 00:59:40.000000000 +0900
+++ qr-0.4.0/qr-0.4.0/php_qr.c	2014-11-16 01:01:26.000000000 +0900
@@ -31,7 +31,9 @@
 #include <Zend/zend_exceptions.h>
 #include "qr.h"
 #include "qr_util.h"
-#include <main/php_logos.h>
+#if PHP_VERSION_ID < 50500
+#  include <main/php_logos.h>
+#endif
 #include "qr_logos.h"

 #if PHP_QR_USE_GD_WRAPPERS
@@ -892,7 +894,9 @@
 	_qr_wrappers_init(INIT_FUNC_ARGS_PASSTHRU);
 #endif
 	REGISTER_INI_ENTRIES();
+#if PHP_VERSION_ID < 50500
 	php_register_info_logo(QR_LOGO_GUID, QR_LOGO_TYPE, qr_logo, QR_LOGO_SIZE);
+#endif

 	QR_REGISTER_CONSTANT(QR_EM_AUTO);
 	QR_REGISTER_CONSTANT(QR_EM_NUMERIC);
@@ -1036,7 +1040,9 @@
 PHP_MSHUTDOWN_FUNCTION(qr)
 {
 	UNREGISTER_INI_ENTRIES();
+#if PHP_VERSION_ID < 50500
 	php_unregister_info_logo(QR_LOGO_GUID);
+#endif

 	return SUCCESS;
 }



