require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "https://pdepend.org"
  url "https://static.pdepend.org/php/2.5.0/pdepend.phar"
  sha256 "0f632ea6d7ab26deabcb9f6a95c337fdd5fbba2199e4aef93ff18a759dec4999"

  bottle do
    cellar :any_skip_relocation
    sha256 "b62a8d6401074b35b9b315999b85af7fd0c699c3b16bead310237bc10505afe6" => :sierra
    sha256 "74a2f4c7ef498e4a24068132e86cc56f00a4151e90126dcab61a0aba3d508916" => :el_capitan
    sha256 "74a2f4c7ef498e4a24068132e86cc56f00a4151e90126dcab61a0aba3d508916" => :yosemite
  end

  test do
    system "#{bin}/pdepend", "--version"
  end
end
