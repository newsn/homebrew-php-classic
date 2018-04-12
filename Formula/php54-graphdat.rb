require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Graphdat < AbstractPhp54Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "33e68325d62204d4144ff5dfc12d5795e7d5b03a250e5aa699ef4c38f8538b4c" => :el_capitan
    sha256 "64e8d95de6ab82ba976acccd53f9f57714ed49ec4ee25ddc38c9974d48ba9866" => :yosemite
    sha256 "a83042353160ec04b0b28b6955dc4b53089cf98fb971293be8a1d810591f63a0" => :mavericks
  end

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file if build.with? "config-file"
  end
end
