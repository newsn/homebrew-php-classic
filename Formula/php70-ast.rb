require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ast < AbstractPhp70Extension
  init
  desc "exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.5.tar.gz"
  sha256 "a1fcc1c9a2c48a1bda5d3f18a8616e3964c25d4d10a23d9f97fb2af46712e42e"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any
    sha256 "289f41974d101bebeb8c8c047ceac828c3ba702250c46c113e0480de0385cb90" => :high_sierra
    sha256 "9a99263ebe2860b92cf8c941caee10e4fc9507ac1bd7cd7541f718b6fb6e5d48" => :sierra
    sha256 "681e0ca5312fbfb0a5aac3651c3a0ad17a9ccb5d3e7d78c372b30ed0510f0bc2" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
