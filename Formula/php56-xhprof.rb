require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xhprof < AbstractPhp56Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/facebook/xhprof"
  url "https://github.com/facebook/xhprof/archive/254eb24dcfa763c76c57b472093ebc4b81af2b7d.tar.gz"
  sha256 "c891ce1bf6730c67bd1dae6fb9b428e3adaf9c7b2008791199ba51a8556683ba"
  head "https://github.com/facebook/xhprof.git"
  version "254eb24"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "324b1a1dffac750172d3e0dbd1a1ba89117b54b9e1499fa61e6b68f66b328b75" => :el_capitan
    sha256 "a34fee24d050b1cdb5096e592c3dcd7e9df52f43c2c38611d5dc5e3a90a62d7e" => :yosemite
    sha256 "81104762bdf370b7f407ba6c73aa3852bc5694baf7990987f1c8b387c51e1f16" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "extension" do
      ENV.universal_binary if build.universal?

      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install "modules/xhprof.so"
    end

    prefix.install %w[xhprof_html xhprof_lib]
    write_config_file if build.with? "config-file"
  end
end
