require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xhprof < AbstractPhp53Extension
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
    sha256 "7cf05be4a664db0cd65ea0a0eac37325faebc6d773129ddd62993f84975a266d" => :el_capitan
    sha256 "03b76a5568bf0dc2c02af53a31a3e2c6923d0fe2eb6fae6c72d633a96d06a10f" => :yosemite
    sha256 "32d159a06b2f89a6088249a59e28b4090a557f0456f6f832bb3e31d6e06078ae" => :mavericks
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
