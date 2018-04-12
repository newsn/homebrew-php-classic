require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ssh2 < AbstractPhp71Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "c592b8a2490be389e88dd08692d25846c279b769e4e528831fbaf50e37ddee45" => :high_sierra
    sha256 "5c41c3926caee738d06534834c879a8d7105ac2245021241ece8a542d57f3394" => :sierra
    sha256 "9845acbc5f17eda952182149ca99d06942a9ad7b25681d0f948a72dad2456f8d" => :el_capitan
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
