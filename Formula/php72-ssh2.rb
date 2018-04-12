require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ssh2 < AbstractPhp72Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "e4101b961d115589f08423c683320bc9fec217a1e8dce07f64ecd678243d8b9d" => :high_sierra
    sha256 "7f6017e222d38cdb8e420a471bf0cd76cee729781e7c4c57bda6cb4f9402ec8c" => :sierra
    sha256 "46a8603589eeae00992327794e21653747eeb71f1d451b348ede3b8fbbd41c24" => :el_capitan
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
