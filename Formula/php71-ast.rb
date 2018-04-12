require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ast < AbstractPhp71Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.5.tar.gz"
  sha256 "a1fcc1c9a2c48a1bda5d3f18a8616e3964c25d4d10a23d9f97fb2af46712e42e"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any
    sha256 "a079843102f81c79b24d627baa679bdfc6e822e3d54ebc2fc08252b4b0b88784" => :high_sierra
    sha256 "ccf13e838f6cf0e7443d39bccab3d17354a153753e665f29b7080fcea4b325d2" => :sierra
    sha256 "7a8621366cf388b0158a67d2106eea5ca2918683f1d85e854d864cc134afb309" => :el_capitan
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
