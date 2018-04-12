require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Trace < AbstractPhp55Extension
  init
  desc "PHP extension and tool for low-overhead tracing"
  homepage "https://pecl.php.net/package/trace"
  url "https://pecl.php.net/get/trace-1.0.0.tgz"
  sha256 "068a5c168ee3fd4249cb41ea98a84affc1f8023d3b5745c0d8f9a305c2d672b1"
  head "https://github.com/Qihoo360/phptrace.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3bc997f737e2c4277a77b83e887e4f23dba0c3d258b9b01d41a5a77b391220a8" => :sierra
    sha256 "79c84f199a374ceb270e72b94626ebe1913cdef1c1675b07e7954e180ca90136" => :el_capitan
    sha256 "bee15375eb639991eebe2d36f2ae7e4d2b9608d43e3e358752ae301cf7c54d9a" => :yosemite
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
