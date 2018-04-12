require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ssh2 < AbstractPhp70Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "97c21618bb4778a80e19a7219aefe1b56601f15bf7bde08d57e94794c9d9b9a8" => :high_sierra
    sha256 "1f7ee48dbd732f3071e401eff324243fc36c4ce6a06d9f79b85618d0397183cb" => :sierra
    sha256 "bc80e5eb901f483a6181975c50342e4b971e816f1818d7fcc9e007ef1e9c092f" => :el_capitan
  end

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?
    
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
