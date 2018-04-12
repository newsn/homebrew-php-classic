require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ioncubeloader < AbstractPhp54Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "af0b548d0e27e6fea9f0b5ee73b2c2099e1cd67f6dd9fd74d2e718ff151d994f"
  version "10.0.3"

  bottle do
    cellar :any_skip_relocation
    sha256 "ed23180485fd59ae81b9c72ee6f923f9b27bbd7b5e30719e81508b0781f833ad" => :high_sierra
    sha256 "ed23180485fd59ae81b9c72ee6f923f9b27bbd7b5e30719e81508b0781f833ad" => :sierra
    sha256 "ed23180485fd59ae81b9c72ee6f923f9b27bbd7b5e30719e81508b0781f833ad" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.4.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
