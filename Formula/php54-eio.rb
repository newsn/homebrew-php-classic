require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Eio < AbstractPhp54Extension
  init
  desc "interface to the libeio library"
  homepage "https://pecl.php.net/package/eio"
  url "https://pecl.php.net/get/eio-1.2.5.tgz"
  sha256 "ee7b21aa413cbe39caaef1d2eb893fa3bcb9a278b5665c28d179a83a4a1bdb51"
  head "https://bitbucket.org/osmanov/pecl-eio.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "604a13b8713832005dad1a0e5c64a8a9a23c1a42d33d9fcc7ddcfb53028200e5" => :el_capitan
    sha256 "81398cef9e062251faf62d3fd523f6aa57521c4f9427ab007c3b506e02f040de" => :yosemite
    sha256 "43a36142c373e7dfc1c2efac7b2881924fb66a40e9012b5ac4b33421475f403f" => :mavericks
  end

  depends_on "libevent" => :build

  # https://bitbucket.org/osmanov/pecl-eio/pull-requests/2
  patch :DATA

  def install
    Dir.chdir "eio-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-eio"
    args << "--enable-eio-sockets"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/eio.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff --git a/eio-1.2.5/libeio/ecb.h b/eio-1.2.5/libeio/ecb.h
index e4a1e97..79c4f71 100644
--- a/eio-1.2.5/libeio/ecb.h
+++ b/eio-1.2.5/libeio/ecb.h
@@ -456,7 +456,7 @@ ecb_inline uint64_t ecb_rotr64 (uint64_t x, unsigned int count) { return (x << (
   #define ecb_unreachable() __builtin_unreachable ()
 #else
   /* this seems to work fine, but gcc always emits a warning for it :/ */
-  ecb_inline void ecb_unreachable (void) ecb_noreturn;
+  ecb_noreturn ecb_inline void ecb_unreachable (void);
   ecb_inline void ecb_unreachable (void) { }
 #endif
 
