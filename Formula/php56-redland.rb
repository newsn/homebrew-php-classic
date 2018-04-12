require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redland < AbstractPhp56Extension
  init
  desc "Redland RDF Libraries for PHP"
  homepage "http://librdf.org"
  url "http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
  sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"

  bottle do
    cellar :any
    rebuild 1
    sha256 "85530f3f07ae5b9872daf144f083657b1c6d4859fb283cf10f28b7c3eb3ab8c0" => :el_capitan
    sha256 "c18b2564c8f1c1c7d06aec39b72bb89af296294e75e7506767899ce6459db07b" => :yosemite
    sha256 "b751e2eb1fa57ce6722763ca949122ead5730b059ad3a1823ba6f50da46cb876" => :mavericks
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
