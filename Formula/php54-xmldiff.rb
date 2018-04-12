require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xmldiff < AbstractPhp54Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-0.9.2.tgz"
  sha256 "60d7d7fde2ebb695ae2cb26803153ad07a6146e0d70c102b3403131c86177550"

  bottle do
    cellar :any_skip_relocation
    sha256 "0fc9c282d4ca39fd2037d3fffc6879b3ec810e2031ab189110ba139252acb797" => :el_capitan
    sha256 "4a61d6ec6a3814cef60e387615f75562e79f7c453dd77f64b80fa0613bf52aa7" => :yosemite
    sha256 "e325b6d144f24bb9106141b4c1c55286af6e8adf5eae4abedcc769a4d1fe7c99" => :mavericks
  end

  def install
    Dir.chdir "xmldiff-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
