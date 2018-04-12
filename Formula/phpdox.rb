require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.11.0/phpdox-0.11.0.phar"
  sha256 "32323c75e3ba70f64b2e8ba4df1ddb163407c87de75ae33d558f83bf1615285e"

  bottle do
    cellar :any_skip_relocation
    sha256 "c8c9c337792bb311bc96529b8bf3277dc4771b4c641a29042c3a659c490565c4" => :high_sierra
    sha256 "c8c9c337792bb311bc96529b8bf3277dc4771b4c641a29042c3a659c490565c4" => :sierra
    sha256 "c8c9c337792bb311bc96529b8bf3277dc4771b4c641a29042c3a659c490565c4" => :el_capitan
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end
