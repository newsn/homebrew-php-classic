require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Sundown < AbstractPhp53Extension
  init
  desc "Sundown is a fast, robust Markdown parsing library for PHP5"
  homepage "https://pecl.php.net/package/sundown"
  url "https://pecl.php.net/get/sundown-0.3.11.tgz"
  sha256 "0a143a268f43f5f2a07988116acfa62671fad4636b84c0750327042f9cb8004f"

  bottle do
    cellar :any_skip_relocation
    sha256 "c8ea6901e7aa031b10c83e1d48c80c5d7d0af0aafa1d2926e78ae67f295dfbbe" => :el_capitan
    sha256 "fd816980b9539739b113f1cb92e481bf1cff2e7d6485aeffbc1667bdd97feeff" => :yosemite
    sha256 "fae2b14bc9ca0a04e29147faa3378db1d694f7430010400c5f5ae0b0ac028ddd" => :mavericks
  end

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file if build.with? "config-file"
  end
end
