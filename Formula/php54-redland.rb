require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redland < AbstractPhp54Extension
  init
  desc "Redland RDF Libraries for PHP"
  homepage "http://librdf.org"
  url "http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
  sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"

  bottle do
    cellar :any
    rebuild 1
    sha256 "29759e97fdd46293fad154446f6ff7a6826bdeabe3a7a77f8f4ea5dba22efcca" => :el_capitan
    sha256 "77be3535ae1ad95bf3576d1ea1b00a3839f1c3ce74aa975296b9f3834af83183" => :yosemite
    sha256 "79cbdb4584559df6dbc9e4c21be2e702ffe4349e774f8a6a5ff4cfcdad530b5f" => :mavericks
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
