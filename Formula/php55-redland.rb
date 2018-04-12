require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redland < AbstractPhp55Extension
  init
  desc "Redland RDF Libraries for PHP"
  homepage "http://librdf.org"
  url "http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
  sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"

  bottle do
    cellar :any
    rebuild 1
    sha256 "ec4c548791a397425850d4d0197a01f05ff26b45eae3be681ff7ea75d101df70" => :el_capitan
    sha256 "d8ab7c022f13a1a7256a4deb18774d109eb7a72622eda7123709549b12a56ae3" => :yosemite
    sha256 "41812c5c2316f0df28cc999b74db9f0ff8f91526015bc2e349d7853b0f6014e6" => :mavericks
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
