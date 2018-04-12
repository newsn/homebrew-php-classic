require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Wbxml < AbstractPhp55Extension
  init
  desc "WBXML to XML conversion"
  homepage "https://pecl.php.net/package/wbxml"
  url "https://pecl.php.net/get/wbxml-1.0.3.tgz"
  sha256 "8a2e36aa1e59712614734a150d4bc2c09c1e7d1f9b90404beeb99d32d19d15ae"
  head "https://svn.php.net/repository/pecl/wbxml/trunk/"

  bottle do
    cellar :any
    sha256 "98b1bcb422b207b3b3ee2eaf6adc0670669fa5f1ef544667e58b9df27ba06587" => :yosemite
    sha256 "07ded52bf770167c056fd8684ae875339cc6145cfcd2b6a1a0317e83102dcf53" => :mavericks
  end

  depends_on "libwbxml"

  # php-wbxml looks for the libwbxml headers in the wrong location
  patch :DATA

  def install
    Dir.chdir "wbxml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-wbxml=#{Formula["libwbxml"].opt_prefix}"
    system "make"
    prefix.install "modules/wbxml.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff -rBNu wbxml-1.0.3/wbxml-1.0.3/config.m4 wbxml-patched/wbxml-1.0.3/config.m4
--- wbxml-1.0.3/wbxml-1.0.3/config.m4 2009-02-22 03:30:57.000000000 -0800
+++ wbxml-patched/wbxml-1.0.3/config.m4 2013-01-26 03:55:21.000000000 -0800
@@ -43,7 +43,7 @@
   ],-L$WBXML_LIBDIR)

   PHP_ADD_LIBRARY_WITH_PATH(wbxml2, $WBXML_LIBDIR, WBXML_SHARED_LIBADD)
-  PHP_ADD_INCLUDE($WBXML_DIR/include)
+  PHP_ADD_INCLUDE($WBXML_DIR/include/libwbxml-1.0/wbxml)

   for i in $PHP_LIBEXPAT_DIR /usr/local /usr; do
     for j in $PHP_LIBDIR lib64 lib; do
