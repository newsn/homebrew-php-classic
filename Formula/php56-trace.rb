require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Trace < AbstractPhp56Extension
  init
  desc "PHP extension and tool for low-overhead tracing"
  homepage "https://pecl.php.net/package/trace"
  url "https://pecl.php.net/get/trace-1.0.0.tgz"
  sha256 "068a5c168ee3fd4249cb41ea98a84affc1f8023d3b5745c0d8f9a305c2d672b1"
  head "https://github.com/Qihoo360/phptrace.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ff20af021a360b2c730830b9cc2d4222288e1374d40e41175fff81dbaa2afead" => :sierra
    sha256 "c3442ec64c2dfa73ac6bae388d988b8934b1744e9486a755d551b361b006ba9b" => :el_capitan
    sha256 "8ef3ca4db9950628a2a107bbc3a26d353ac1a2a6333ee6007c9a8e849bc3814a" => :yosemite
  end

  def install
    Dir.chdir "trace-#{version}/extension" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make", "all", "build-cli"
    prefix.install "modules/trace.so"
    bin.install "../src/phptrace"

    write_config_file if build.with? "config-file"
  end

  test do
    system "#{bin}/phptrace", "-h"
  end
end
