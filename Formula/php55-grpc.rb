require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Grpc < AbstractPhp55Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "736cf18fb002640ea2776833cbf37449ec4e7deca54a774069d098f056f9b095" => :high_sierra
    sha256 "6a376c140551de5a606ec908ecbba58935df04cbcaef258a56c7305d58158432" => :sierra
    sha256 "6579f1f77baaa642e347cf858a4e14a010064b7e46f0731954cb928f6c44b715" => :el_capitan
  end

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc=#{HOMEBREW_PREFIX}",
           "--prefix=#{prefix}", phpconfig,
           "CFLAGS=-Ithird_party/boringssl/include"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file if build.with? "config-file"
  end
end
