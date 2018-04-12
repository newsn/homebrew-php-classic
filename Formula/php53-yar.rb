require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yar < AbstractPhp53Extension
  init
  desc "Light, concurrent RPC framework"
  homepage "https://pecl.php.net/package/yar"
  url "https://pecl.php.net/get/yar-1.2.3.tgz"
  sha256 "8f39e6174476e2eae6021f83b69bcf77ee22949654a43c9985dde1a3c7bcf66e"

  bottle do
    cellar :any_skip_relocation
    sha256 "7cb2d283a890204067ae6d232d5bd0469e97aae0c9c9ed22a1d1068353caee36" => :el_capitan
    sha256 "a0eaed97b1090beeefb4f781e7d0e0f0b4c6adcea278252749f9d80789654868" => :yosemite
    sha256 "6f91b62b9a1a87a93497818842b8d08bec52c323ec0e38fdb46868edfceeb090" => :mavericks
  end

  def install
    Dir.chdir "yar-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yar.so"
    write_config_file if build.with? "config-file"
  end
end
