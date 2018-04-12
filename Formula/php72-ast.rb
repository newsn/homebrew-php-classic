require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ast < AbstractPhp72Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.5.tar.gz"
  sha256 "a1fcc1c9a2c48a1bda5d3f18a8616e3964c25d4d10a23d9f97fb2af46712e42e"
  head "https://github.com/nikic/php-ast.git"
  revision 1

  bottle do
    cellar :any
    sha256 "5e7486bc3c708a6f60340e130716d48d20fda45bd0c3f059b75c97a9b9a99caa" => :high_sierra
    sha256 "ab29ae7866e6d176e457535241636fd1fb3d6504cb1f51425b4bf06bc499605c" => :sierra
    sha256 "998d38980deacca637470e8dbfab3883d1596c723f2d39e3118968414a42b23e" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
