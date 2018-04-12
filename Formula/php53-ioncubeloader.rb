require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Ioncubeloader < AbstractPhp53Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "1c9b17a4750578299277cc69631769ecc63708da0b12253cb333434add10332a"
  version "6.0.9"

  bottle do
    cellar :any_skip_relocation
    sha256 "028383929a4d720b6fa7984900514bf5a23732c1cc540db9c75a1770a04a5877" => :sierra
    sha256 "5ca1fb054e9f4d2c7a01a81398cdf8a0967394541d217e4b84cecc65f69857e0" => :el_capitan
    sha256 "2f88d04d1dc2b03294b9f3f095471ab99937a0a391379764d5f87b1832cb08d7" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.3.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
