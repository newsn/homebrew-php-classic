require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xhprof < AbstractPhp54Extension
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
    sha256 "8d11c7030047300d5425ccf44e05fae27d6c84fafb6d4b0ee756ea7a105637ae" => :el_capitan
    sha256 "4965c01344b6c9c36983219711b3da9a9ebc147d1e0c7834399dec6453dd693d" => :yosemite
    sha256 "58545ad47215d6d9f9b057a8014a4cbf7968e29d6b7240a8ad0416276145e927" => :mavericks
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
