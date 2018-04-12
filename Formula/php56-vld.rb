require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Vld < AbstractPhp56Extension
  init
  desc "Provides functionality to dump the internal representation of PHP scripts"
  homepage "https://pecl.php.net/package/vld"
  url "https://pecl.php.net/get/vld-0.13.0.tgz"
  sha256 "f61fe6501b6f30cf5628b7fd0e2c41185bb9bfac96b765c8b967a8ba01f7bf8b"
  head "https://github.com/derickr/vld.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa3cf8f40db198bef2b20d55deaf747f2315d37edb0ac4aa4ee74837452fa213" => :el_capitan
    sha256 "1ecfa0ecc9bdc1b63d428e21ca0b2473a8e5ee7029788c31fd5ffc50fc2d5abf" => :yosemite
    sha256 "1c6beae202e049b716e0f08bd888a33e8be47b6858667b58141ef5031ec9332c" => :mavericks
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
