require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.11.1.tar.gz"
  sha256 "7a7da34b06db4232e959573375867171b266c59ef54b93276b19e48c360a2b82"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9ad7deb432de53810c9f9d5ee7d5fbf2993c2605bb3dea41d338ba5b1a96d131" => :high_sierra
    sha256 "bea1ec183b6b9957c701dba49e025d0d5e13105033b7a5fd29763af37d7f3f73" => :sierra
    sha256 "1d70652cb9a098c7ea8be5ce0bed5f88a4bd7c35367bbf565c09d0cbd57d8745" => :el_capitan
  end

  depends_on "php72-ast"
  depends_on "php72"

  conflicts_with "phan@0.10", :because => "it provivides a phan binary"
  conflicts_with "phan@0.8", :because => "it provivides a phan binary"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
