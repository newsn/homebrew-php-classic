require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Grpc < AbstractPhp70Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "fc8578f660b0fea52543673542c48373839c99a2e2e81ac10a373eebeaffe3ee" => :high_sierra
    sha256 "8e2e24beba4f9b0a612444e9e908cce9763e47992d7ea9f6707d07a90e6e0c49" => :sierra
    sha256 "9710e1351a825043d0548b8ac8f72b6bfc74b4032e13112d15beba93f33be7e4" => :el_capitan
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
