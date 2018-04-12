require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Mondrian < AbstractPhpPhar
  init
  desc "Analyse and refactor highly coupled classes"
  homepage "https://trismegiste.github.io/Mondrian/"
  url "https://github.com/Trismegiste/Mondrian/raw/v1.3.3/bin/box/mondrian.phar"
  version "1.3.3"
  sha256 "8934447cd92e826a17f0056a27b3b98777a5e5126c29858919006551d861e340"

  bottle do
    cellar :any_skip_relocation
    sha256 "400b7e1ac40eb6cbf23492dcd711a615fb49a55e292c64d869445957e3019d03" => :sierra
    sha256 "93eb03f757e8b9d7d91f5a2c041901d56287e9174939554875bc2483f8bcce15" => :el_capitan
    sha256 "0a17c6fa9c186fc59d53f3d235a126b30a4d952c1acf49bd7a28df4f22972a10" => :yosemite
    sha256 "6eea47f4970445bac31fb66240b2dc24387277f4ef50a6a41eee400e45f46a86" => :mavericks
  end

  depends_on "graphviz"

  test do
    system "mondrian", "--version"
  end
end
