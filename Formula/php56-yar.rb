require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yar < AbstractPhp56Extension
  init
  desc "Light, concurrent RPC framework"
  homepage "https://pecl.php.net/package/yar"
  url "https://pecl.php.net/get/yar-1.2.3.tgz"
  sha256 "8f39e6174476e2eae6021f83b69bcf77ee22949654a43c9985dde1a3c7bcf66e"

  bottle do
    cellar :any_skip_relocation
    sha256 "e753b660ee682a442112ec3cd5d971dca1a134f92bd263330a8eaa40048c0476" => :el_capitan
    sha256 "b76a3b05fe11a6fad4bc681929637a2e3ceb570fb7ba97da428eb0bae38290f1" => :yosemite
    sha256 "9894e07a86f528f1c8be4ff5f5d0d3ee332b225b206cc79a392742c3ebdc9a95" => :mavericks
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
