require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yar < AbstractPhp54Extension
  init
  desc "Light, concurrent RPC framework"
  homepage "https://pecl.php.net/package/yar"
  url "https://pecl.php.net/get/yar-1.2.3.tgz"
  sha256 "8f39e6174476e2eae6021f83b69bcf77ee22949654a43c9985dde1a3c7bcf66e"

  bottle do
    cellar :any_skip_relocation
    sha256 "65dec771df7cb13cf56db157eb29c19c9106de0b3d0f5566614ff2d50d5a2555" => :el_capitan
    sha256 "e970ec1300f0e421493cedb9ca887b5d858c32b82a3361a6c6d2f6ad5a2a4271" => :yosemite
    sha256 "90102278f8f876be2c6f610e80112d6eeec05c51a9d91ee8cf7f104bdbf2161d" => :mavericks
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
