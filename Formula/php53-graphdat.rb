require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Graphdat < AbstractPhp53Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "6993b9fa77c125d3504bdb478673c20bf3389b4c9d5aa03e38c5710431e85a25" => :el_capitan
    sha256 "510d09d7ebc1afed374de331a48176de2e5cf0a28b8f5ae9ea16f754a3924472" => :yosemite
    sha256 "8750623028c3828066dac0a04b295926c1ea0db099403906ef9d54dc7f59541f" => :mavericks
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
