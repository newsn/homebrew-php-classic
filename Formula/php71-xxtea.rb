require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xxtea < AbstractPhp71Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "735c9516ea414d40aa7aecee4f49455271c3f9d7f5af63035a1fe274a18d557a" => :el_capitan
    sha256 "f55a7702b71a8af7e6af67f85d3e530794fea49d832c83a4ed1b1b1027ef5236" => :yosemite
    sha256 "2d6e711bbc9f3d3bb555bac157653cfb592f90e6ef58fe9c9c7256b5bcb33e7f" => :mavericks
  end

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end
