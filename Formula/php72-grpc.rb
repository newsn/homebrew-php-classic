require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Grpc < AbstractPhp72Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "4053d00652d42bf6335e1fdccb43a4732e4ab5f48a8ce3ae70677399d4630af5" => :high_sierra
    sha256 "b37a6ae08c9a447280ce5701f224f0ad24aa402df1d4f2400a35afb5385d98a1" => :sierra
    sha256 "24f2f32cb26681cc9c3dd63d903821dcac1ddca4ae319cd9b161b42b9e700fc6" => :el_capitan
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
