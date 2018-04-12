class Phplint < Formula
  desc "Validator and documentator for PHP 5 and 7 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-3.0_20160307.tar.gz"
  version "3.0-20160307"
  sha256 "7a361166d1a6de707e6728828a6002a6de69be886501853344601ab1da922e7b"

  if MacOS.version <= :mavericks
    if Formula["php55"].linked_keg.exist?
      depends_on "php55"
    elsif Formula["php70"].linked_keg.exist?
      depends_on "php70"
    else
      depends_on "php56"
    end
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "99ac1b93dae5a1faa33715eddf534db4fd89c685a314a41ee48cb2983fd40cce" => :sierra
    sha256 "a0bbcf5029964b90c8c0c92b60d8d38872ddc3eefaf277dbafad14b8fff60bdb" => :el_capitan
    sha256 "caec309e27822f33611334495bc5eb6246ae7d40b2317dd88b79958478b5918e" => :yosemite
    sha256 "73551ae1bd5d72be2d7b78e3edb8578eadcab799fc96a42c198c9eb456bba794" => :mavericks
  end

  def install
    inreplace "php", "/opt/php/bin/php", "/usr/bin/env php"
    inreplace "phpl", "$__DIR__/", "$__DIR__/../"
    inreplace "phplint.tcl", "\"MISSING_PHP_CLI_EXECUTABLE\"", "#{prefix}/php"
    inreplace "phplint.tcl", "set opts(phplint_dir) [pwd]", "set opts(phplint_dir) #{prefix}"

    prefix.install "modules"
    prefix.install "stdlib"
    prefix.install "utils"
    prefix.install "php"

    bin.install "phpl"
    bin.install "phplint.tcl"
  end

  test do
    system "phpl", "--version"
  end
end
