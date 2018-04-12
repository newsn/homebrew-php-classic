require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpctags < AbstractPhpPhar
  init
  desc "Ctags compatible index generator written in pure PHP"
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/0.6.0.tar.gz"
  sha256 "ed9ddbb56f672673274de7ef066071e703b5090d47c9ccc31442dd43b5775190"

  bottle do
    cellar :any_skip_relocation
    sha256 "a7b00c376fd9ccf9f273e876bd11798dfb1d6ee0641d5ce9a7d16ff83dbb471b" => :sierra
    sha256 "3f830cb241d00b38569594b4963d3d337ef809e597a0b202bb0dc7ae437f0c7f" => :el_capitan
    sha256 "30aabc214d07d39589ba24bd74c065b5cc3dfd0b44be1417d83eeb62a5faab0f" => :yosemite
    sha256 "2673139ea129e2afca83fe7fa3cc4913def1cd3bfde5f453d9425aeaf0c83f64" => :mavericks
  end

  def install
    system "make"
    File.rename("build/phpctags.phar", "build/phpctags")
    bin.install "build/phpctags"
  end

  test do
    system "phpctags", "--version"
  end
end
