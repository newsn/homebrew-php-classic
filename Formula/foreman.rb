require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Foreman < AbstractPhpPhar
  init
  desc "Laravel scaffolding application"
  homepage "https://github.com/Indatus/foreman"
  url "https://github.com/Indatus/foreman/raw/v1.0.0/foreman.phar"
  version "1.0.0"
  sha256 "ec805e9b39dd520f6b4a368abe9ae9ad505f857617a2a1d72750e00b71d48bdd"
  bottle do
    cellar :any_skip_relocation
    sha256 "1c5fea97a2a0bb52a0da81e4f6f81709ec87c91ed61813e2b7f2c09b31e153c7" => :sierra
    sha256 "1833d830da20b5d38f10261b5cd519babe30284c4b842eb3a25f1834f73d29c1" => :el_capitan
    sha256 "d00f4675475cb88b891f819fd60bb65fe0442096f74ad016f6e1f258534db103" => :yosemite
    sha256 "5632a026ceef488af7b2174021b0dcfb07df71732df56ad338325342cd219513" => :mavericks
  end

end
