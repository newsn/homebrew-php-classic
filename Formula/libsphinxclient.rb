class Libsphinxclient < Formula
  desc "Client for sphinx"
  homepage "http://www.sphinxsearch.com"
  url "https://github.com/sphinxsearch/sphinx/archive/2.2.11-release.tar.gz"
  version "2.2.11"
  sha256 "c53cf3fe197f849d43810263dc02987503a02e0d9938881fc97d48b4f783a54d"

  head "https://github.com/sphinxsearch/sphinx.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b0c620658e994f87519fa5b51693756d6ae0e89d1ebfea33a579b3937484af5" => :sierra
    sha256 "c04bd488736399c9f45df2253a0cdfc19386005fd8ede000ee9eecd389d85357" => :el_capitan
    sha256 "573122c95a3cab22ed70c13e1e397e7fc804493815bf8001a1edfd26dfe25918" => :yosemite
    sha256 "6cd7901c9ee0ab4ce81224f7635c2d05b87521bd7b1ddd9475aeda53dbaa5d47" => :mavericks
  end

  devel do
    url "http://sphinxsearch.com/files/sphinx-2.3.1-beta.tar.gz"
    sha256 "0e5ebee66fe5b83dd8cbdebffd236dcd7cd33a7633c2e30b23330c65c61ee0e3"
  end

  def install
    Dir.chdir "api/libsphinxclient"

    # libsphinxclient doesn"t seem to support concurrent jobs:
    #  https://bbs.archlinux.org/viewtopic.php?id=77214
    ENV.deparallelize

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert File.exist?("#{include}/sphinxclient.h")
    assert File.exist?("#{lib}/libsphinxclient.a")
  end
end
