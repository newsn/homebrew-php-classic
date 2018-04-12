require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org"
  url "https://github.com/phpmetrics/PhpMetrics/raw/v1.10.0/build/phpmetrics.phar"
  version "1.10.0"
  sha256 "a7aac1115f6ad30365d89655744bb2a3bfed6e798ad30e37ddefd1fa0618da57"

  bottle do
    cellar :any_skip_relocation
    sha256 "e5baa9b2301e35f277d89631aee4fe99a9d2b4a45e579646c1c06a615d8aecfe" => :sierra
    sha256 "9e2cbaea4fbb60e35d623d89d1b9d0a0be0c08419445f20b249f513a792ead22" => :el_capitan
    sha256 "2b9d46d652c62382aae6c54dbeb261a14cecdec837b68280f711e24e2b5f2661" => :yosemite
    sha256 "d4759f68c16fc4767584040e35805c11a2acc2e1afb8c0fcd10d769e86c9672a" => :mavericks
  end

  test do
    system "phpmetrics", "--version"
  end
end
