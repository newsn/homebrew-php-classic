require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Vld < AbstractPhp55Extension
  init
  desc "Provides functionality to dump the internal representation of PHP scripts"
  homepage "https://pecl.php.net/package/vld"
  url "https://pecl.php.net/get/vld-0.13.0.tgz"
  sha256 "f61fe6501b6f30cf5628b7fd0e2c41185bb9bfac96b765c8b967a8ba01f7bf8b"
  head "https://github.com/derickr/vld.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e83b41dab0329076eabbf8d3720e2bf86516719e573124af33c29079d819e34" => :el_capitan
    sha256 "18e633c55e847fadc2549c3ba07d67217a55ce1ed7fbe61fa68dc2db2deef000" => :yosemite
    sha256 "48d50d9a52a557b686dc3fe23a9a3972c2f9bb5dc9061e1b0261ddd21f316145" => :mavericks
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
