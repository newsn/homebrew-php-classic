require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Vld < AbstractPhp53Extension
  init
  desc "Provides functionality to dump the internal representation of PHP scripts"
  homepage "https://pecl.php.net/package/vld"
  url "https://pecl.php.net/get/vld-0.13.0.tgz"
  sha256 "f61fe6501b6f30cf5628b7fd0e2c41185bb9bfac96b765c8b967a8ba01f7bf8b"
  head "https://github.com/derickr/vld.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dcbc8e82668ec3bc180d5bba0cd5b107e32841bb6093c39c1faaa91d4b181cb0" => :el_capitan
    sha256 "b161890ac2ddc68dd4c026a10694acf36b4ca31d92f88f7e182119bf1ab1a1d3" => :yosemite
    sha256 "6c7b7219d8971f7559357ee8ebf7b0bb2f3702771a55638758efd09a5083b172" => :mavericks
  end

  def install
    Dir.chdir "vld-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/vld.so"
    write_config_file if build.with? "config-file"
  end
end
