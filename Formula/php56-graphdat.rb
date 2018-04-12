require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Graphdat < AbstractPhp56Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "c7f32d9d39a5be060b3c1241214382405c767ef9f07bb95ed49fecb5fc9ab15a" => :el_capitan
    sha256 "718f727a191f36cc43ca3a10a1e2306431364dc37b9ab8eeb0e26e6ecedf19a5" => :yosemite
    sha256 "13281e3f392b4c26dfc96b5f241fe3ddd130f975cc94d7ef5cd6dc49d9cddbec" => :mavericks
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
