require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ioncubeloader < AbstractPhp71Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "cf7a5a1855427c6219645bdc3edef71ab6dc2641cec1d73fb6ca2101f54a7fcc"
  version "10.0.4"

  option "with-thread-safe", "Enable the thread-safe extenstion"

  bottle do
    cellar :any_skip_relocation
    sha256 "47a97cfe121091e31d8137916fdc9d7a93efe875e457d3dfb36dbe3824a324f5" => :high_sierra
    sha256 "595502784b53a450743b863f89ad3f835ad290cbbc9df81d974e1d6702eed9f5" => :sierra
    sha256 "595502784b53a450743b863f89ad3f835ad290cbbc9df81d974e1d6702eed9f5" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_7.1.so" => "ioncubeloader.so" if build.without? "thread-safe"
    prefix.install "ioncube_loader_dar_7.1_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
