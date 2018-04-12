require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/etsy/phan/archive/0.8.10.tar.gz"
  sha256 "4e552b0e764613940f32b888a13090a13ae39f35c9391061c70dc04b422c240f"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "6f58dda8038daa5f1de2c95ff28f0d4ab58a243ba17237f4789b97e550223eae" => :high_sierra
    sha256 "31dc63511d08645cddbf3f986009a4f865d4490d2e751aa51ae66de27ee25c7e" => :sierra
    sha256 "461a37a34890bc30214954dddefa6537b54b89325a6ae049cc3e1189e1764a7c" => :el_capitan
  end

  keg_only :versioned_formula

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
