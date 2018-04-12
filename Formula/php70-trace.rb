require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Trace < AbstractPhp70Extension
  init
  desc "PHP extension and tool for low-overhead tracing"
  homepage "https://pecl.php.net/package/trace"
  url "https://pecl.php.net/get/trace-1.0.0.tgz"
  sha256 "068a5c168ee3fd4249cb41ea98a84affc1f8023d3b5745c0d8f9a305c2d672b1"
  head "https://github.com/Qihoo360/phptrace.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f93bc673417164725875a9944eade01055921f7ebad62f156baeb8fd441b5c7" => :sierra
    sha256 "38d0c971f91ec5d000d4772bb13173f1cf387c3cd67d6427ad2733e408222ace" => :el_capitan
    sha256 "faf1ff2dc6c6de1139c1abbd4ed012e45645c01c4d55daa1cd6f0a86b83f803f" => :yosemite
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
