require File.expand_path("../../language/php", __FILE__)

class PhanAT010 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.2.tar.gz"
  sha256 "a255427696066bebc440ea792c63a68fc80cbfb6de5d837eaa02fbae03670054"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "017c2dd392d0b01f2e3b513b97f561dd2ec62390f567841d8dbf7f57b5e2af3b" => :high_sierra
    sha256 "f862502d313a891c923ad9844eabc7d2b04994b81087a0d6711645c1e2de8ce0" => :sierra
    sha256 "cf5d978a6abeaf951c7ad95b3caffb58a582c7311541323f94dc9a2684376383" => :el_capitan
  end

  keg_only :versioned_formula

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
