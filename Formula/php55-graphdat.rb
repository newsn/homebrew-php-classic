require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Graphdat < AbstractPhp55Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "bc2dfea65884a2bce68cf02c59a9355e68cad47a2c34c5d82efd6a64669d4c50" => :el_capitan
    sha256 "b693a4c7bf977769d615237cc501d0283f1023b7101383bf62e6f019ac2c0601" => :yosemite
    sha256 "5e895dfcffd019efb6c77b5e7b5352df92b9c1700eda1d0f7fb2fc8455b97c54" => :mavericks
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
