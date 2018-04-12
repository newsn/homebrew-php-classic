require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects"
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.10",
    :revision => "e3bf2ed78bbea1dce9f5454a136e5895b313d03a"
  head "https://github.com/symfony/symfony-installer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "df646f411d5bf06312ec9aa6ddf150563fdc05040691fa834a44bb6bba8230f7" => :high_sierra
    sha256 "ec1e33d375425a74e0df848522c67b3ae37d62a14afa4a094cbccec12d71cc63" => :sierra
    sha256 "6d3d018c9f5d121b618a3a2c130587503ce4c09f4a785a455ae3c6bfbd267d33" => :el_capitan
  end

  depends_on PhpMetaRequirement
  depends_on "box" => :build
  depends_on "composer" => :build

  def install
    composer_install
    system "box", "build"
    bin.install "symfony.phar" => "symfony"
  end

  test do
    system bin/"symfony", "about"
  end
end
