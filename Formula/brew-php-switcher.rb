class BrewPhpSwitcher < Formula
  desc "Switch Apache & CLI configs between PHP versions"
  homepage "https://github.com/philcook/php-switcher"
  url "https://github.com/philcook/brew-php-switcher/archive/v1.7.tar.gz"
  sha256 "06d91314e6694a5406fe3e70ccd0a606fb53cabf8bff09f8983b0036444f0285"
  head "https://github.com/philcook/brew-php-switcher.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3eeb27a0a45004a29622133ad4db075808f21827928222f701b5b21f6f424421" => :high_sierra
    sha256 "3eeb27a0a45004a29622133ad4db075808f21827928222f701b5b21f6f424421" => :sierra
    sha256 "3eeb27a0a45004a29622133ad4db075808f21827928222f701b5b21f6f424421" => :el_capitan
  end

  def install
    bin.install "phpswitch.sh"
    sh = libexec + "brew-php-switcher"
    sh.write("#!/usr/bin/env sh\n\nsh #{bin}/phpswitch.sh $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<~EOS
    To run brew php switcher do the following:
      "brew-php-switcher 53".

    You can select php version 53, 54, 55, 56, 70 or 71.
    EOS
  end

  test do
    system "#{bin}/brew-php-switcher"
  end
end
