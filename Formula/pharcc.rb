require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pharcc < AbstractPhpPhar
  init
  desc "tool that converts your php project into a .phar file"
  homepage "https://github.com/cbednarski/pharcc"
  url "https://github.com/cbednarski/pharcc/releases/download/v0.2.3/pharcc.phar"
  version "0.2.3"
  sha256 "9dee4f814aa04bd92a03b5f1aadbef80a567836d310319f4b2775673522fb959"

  bottle do
    cellar :any_skip_relocation
    sha256 "bba04231b9f82af7f5f308156bdb5ac3bdbc531c8869e909d103b6370c6cc2e6" => :sierra
    sha256 "fe6aa8c8df217518d509d2973c94ae9f79b01c84dd32385cccd9b4343e657a3e" => :el_capitan
    sha256 "bead6dcd4dd811e768a61f8a5b08e91c5bcfa2b15b1fce87085d63dc2d1b7719" => :yosemite
    sha256 "7b0dfbf05ebe66cc5be718c155c8eefe7bb79edebbf17539e20393f8974c46b7" => :mavericks
  end

  test do
    system "pharcc", "--version"
  end
end
