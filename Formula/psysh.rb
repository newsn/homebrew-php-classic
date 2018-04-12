require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.17.tar.gz"
  sha256 "3161ef575702a10e0e7172572470ae59842da5e00f07c24c115562f95dbe0e74"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "114eb6e6905e820714f2797ebcba45978fda25c8a10b8c2f4a965a4e905bf613" => :high_sierra
    sha256 "19f524f82cb8fb41f53390e605e56e723a9cd2ae90d5fcd75d1d4e5d966e2bbe" => :sierra
    sha256 "72641a2e4a81bd1c53199fee362596776e259ef3b1d36b31e27a00cbb26e706e" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install "--no-dev"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/psysh"
  end

  test do
    system "#{bin}/psysh", "--version"
  end
end
