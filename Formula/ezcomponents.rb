class Ezcomponents < Formula
  desc "general purpose PHP components library"
  homepage "http://ezcomponents.org"
  url "http://ezcomponents.org/files/downloads/ezcomponents-2009.2.1-lite.tar.bz2"
  sha256 "c7a4933dc8b100711c99cc2cc842da6448da35a4a95e8874342a92c79b8f8721"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "a8ff044c522d41be7e2fb0d2e84f8a33d86c7e054253b315dff3f70be239723f" => :sierra
    sha256 "b553dfc6b2b6b5098c648484cb4bc19e8ebd1c6787de92b85365990e25c65b79" => :el_capitan
    sha256 "4719c7c4fffbae46151abf469bc84f3f2eea30b70e7e099d3ddf6813cc411a85" => :yosemite
    sha256 "3020beecce6d6c96c638bebe46f9c9997b71caee6d2ebedb07fbff333fbe7f5f" => :mavericks
  end

  def install
    (lib+"ezc").install Dir["*"]
  end

  def caveats; <<~EOS
    The eZ Components are installed in #{HOMEBREW_PREFIX}/lib/ezc
    Remember to update your php include_path if needed
    EOS
  end

  test do
    assert File.exist?("#{lib}/ezc/LICENSE")
  end
end
