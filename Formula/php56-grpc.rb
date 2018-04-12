require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "0db4533c6c5a67abc3a664b722a061e0614d06a7ad42595ad84c056c2d569ffe" => :high_sierra
    sha256 "3067bec14f97eed999cb9ed40d0ba4b25541fdecc34a464655cab9d455635b2f" => :sierra
    sha256 "eb426bee2995c2f055c331f3735803aa540bd5fc91581b46650323923b1d955c" => :el_capitan
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
