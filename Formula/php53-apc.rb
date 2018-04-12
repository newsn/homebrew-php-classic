require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Apc < AbstractPhp53Extension
  init
  desc "Alternative PHP cache"
  homepage "https://pecl.php.net/package/apc"
  url "https://pecl.php.net/get/APC-3.1.10.tgz"
  sha256 "99f260b32592f1b50da9c7a83fad3c5cbdb2484fa01aee6cc04caadd8cd4fc44"
  head "https://svn.php.net/repository/pecl/apc/trunk/"

  stable do
    # fixes "Incorrect version tag: APC 3.1.10 shows 3.1.9"
    # https://bugs.php.net/bug.php?id=61695
    patch :DATA
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "b25e9b35ca1a500531eb04a3264bcfc4c365f41128a427b9a9fd3213e8faa61b" => :el_capitan
    sha256 "990c66e204dd8ba22cb09ab318397554b4e2407044af5cfc071f4bef52af5c44" => :yosemite
    sha256 "2e24df0758c1c47881d308dd58b4c930bc492b53be8b49677fc6fb2ba413ee47" => :mavericks
  end

  devel do
    url "https://pecl.php.net/get/APC-3.1.13.tgz"
    sha256 "5ef8ba07729e72946e95951672a5378bed98cb5a294e79bf0f0a97ac62829abd"
  end

  depends_on "pcre"

  def install
    Dir.chdir "APC-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-apc-pthreadmutex"
    system "make"
    prefix.install %w[modules/apc.so apc.php]
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_segments=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.user_ttl=7200
      apc.num_files_hint=1024
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=0
    EOS
  end
end

__END__
diff --git a/APC-3.1.10/php_apc.h b/APC-3.1.10/php_apc.h
index 77f66d5..aafa3b7 100644
--- a/APC-3.1.10/php_apc.h
+++ b/APC-3.1.10/php_apc.h
@@ -35,7 +35,7 @@
  #include "apc_php.h"
  #include "apc_globals.h"

-#define PHP_APC_VERSION "3.1.9"
+#define PHP_APC_VERSION "3.1.10"

  extern zend_module_entry apc_module_entry;
  #define apc_module_ptr &apc_module_entry
