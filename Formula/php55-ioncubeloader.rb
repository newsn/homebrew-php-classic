require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "af0b548d0e27e6fea9f0b5ee73b2c2099e1cd67f6dd9fd74d2e718ff151d994f"
  version "10.0.3"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d9ad65f1bb4cb74134b80505181e4be134db9977cc96d3087cd75e4d44b0304" => :high_sierra
    sha256 "0d9ad65f1bb4cb74134b80505181e4be134db9977cc96d3087cd75e4d44b0304" => :sierra
    sha256 "0d9ad65f1bb4cb74134b80505181e4be134db9977cc96d3087cd75e4d44b0304" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
