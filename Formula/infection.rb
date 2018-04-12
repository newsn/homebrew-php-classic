require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Infection < AbstractPhpPhar
  desc "AST based PHP Mutation Testing Framework"
  homepage "https://infection.github.io"
  url "https://github.com/infection/infection/releases/download/0.6.0/infection.phar"
  sha256 "1b8a1c617dddf5b61018356a111baabdf5c02439ff841cea57960472f3794136"

  bottle do
    cellar :any_skip_relocation
    sha256 "81e68685615b760a66ca55241fb2f62c9b23b82ef7569ed7d64ab36fde1f268a" => :high_sierra
    sha256 "03c67bfa16bbc2424b917e415e9adb0a8cfa4f88f2f5d955b34bd700642bdc28" => :sierra
    sha256 "03c67bfa16bbc2424b917e415e9adb0a8cfa4f88f2f5d955b34bd700642bdc28" => :el_capitan
  end

  depends_on PhpMetaRequirement
  depends_on "php70-xdebug" if Formula["php70"].linked_keg.exist?
  depends_on "php71-xdebug" if Formula["php71"].linked_keg.exist?

  resource "pubkey" do
    url "https://github.com/infection/infection/releases/download/0.6.0/infection.phar.pubkey"
    sha256 "7a23dff08d1b34333d7eab3a643a56347800083592e55c7e0294bb32fbfc09c8"
  end

  def phar_file
    "infection.phar"
  end

  def install
    super
    resource("pubkey").stage { libexec.install "infection.phar.pubkey" }
  end

  test do
    shell_output("#{bin}/infection --version").include?(version)
  end
end
