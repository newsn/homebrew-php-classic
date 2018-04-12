require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Sqlformat < AbstractPhpPhar
  init
  desc "CLI adaptation of the SqlFormatter library"
  homepage "https://github.com/MattKetmo/sqlformat"
  url "https://github.com/MattKetmo/sqlformat/releases/download/v1.0.0/sqlformat.phar"
  version "1.0.0"
  sha256 "57eecf761142091424a96a651d537229edee686741f412c6b19201e3f3792914"

  bottle do
    cellar :any_skip_relocation
    sha256 "66fcfdfdbf3ab425cb0dbed9e181b9b529290e15cac0a25a6c691b757f1ef1d5" => :sierra
    sha256 "d4c1138ac159084d60b1f491420aa9a4f11cb32a1e19ae6afcf6496661c1bc4a" => :el_capitan
    sha256 "7f9819653a1f445dcfe437bf6896bc3c6672adb91e30863b80ff5768b4faad76" => :yosemite
    sha256 "7f9819653a1f445dcfe437bf6896bc3c6672adb91e30863b80ff5768b4faad76" => :mavericks
  end

  test do
    system "sqlformat", "--version"
  end
end
