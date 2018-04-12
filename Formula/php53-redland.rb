require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redland < AbstractPhp53Extension
  init
  desc "Redland RDF Libraries for PHP"
  homepage "http://librdf.org"
  url "http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
  sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"

  bottle do
    cellar :any
    rebuild 1
    sha256 "5a6db9f445e2303ad53734204dbcdd25136b0c3d1716295a4beb4325e6bb3a35" => :el_capitan
    sha256 "29ef1ae3fb3ee9ec68d7bb584172b397f78b9c7f225b9daecf1dd6217d29e105" => :yosemite
    sha256 "f253a2005e2154887b7d5604066739d5e29f141a1cc37cc58effaa506e4bcad3" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "redland"
  depends_on "raptor"
  depends_on "rasqal"

  def install
    args = %W[
      --disable-dependency-tracking
      --with-php
      --with-php-linking=dylib
    ]

    system "./configure", *args
    system "make"
    prefix.install "php/#{extension}.dylib"
    write_config_file if build.with? "config-file"
  end

  def module_path
    prefix / "#{extension}.dylib"
  end
end
