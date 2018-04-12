require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Envoy < Formula
  include Language::PHP::Composer

  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/archive/v1.4.1.tar.gz"
  sha256 "e96c738861bc027b36c96e5682870ccb811732bf0ea10f41f962e618b43071c2"
  head "https://github.com/laravel/envoy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1152f18c63f3e94b31cd3adc0819c06a8f0fc690576d31a0601dec984051244b" => :high_sierra
    sha256 "89a3c566f79968138afe02078969debce17aba01061c3a82f81e791cfd4b58e5" => :sierra
    sha256 "535e9d009d65db623c4fd36b34ff0974273054a6335847372a95758d883d8678" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"envoy"
  end

  test do
    system "#{bin}/envoy", "--version"
  end
end
