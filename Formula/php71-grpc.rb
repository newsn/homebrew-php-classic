require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Grpc < AbstractPhp71Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "31d18bdf71e96df212fb50034d13dc16af2eab9273c299564d40150e82bd9d41" => :high_sierra
    sha256 "f1c96c709ccca0d4577151be452ca3255b7afb3571250d27957584b82452a211" => :sierra
    sha256 "51530fe5781bc55ce6dc23c21ea2cfe06b59eafe3b4693e15e4c1fd97850ab90" => :el_capitan
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
