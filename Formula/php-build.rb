class PhpBuild < Formula
  desc "Enables multiple PHP versions to be used in parallel"
  homepage "https://php-build.github.io/"
  url "https://github.com/php-build/php-build/archive/v0.10.0.tar.gz"
  sha256 "9f3f842608ee7cb3a6a9fcf592a469151fc1e73068d1c2bd6dbd15cac379857c"
  head "https://github.com/php-build/php-build.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4dfd489892f5e846fcaae4995396e19990f2d950afbc6552d432cbe56a590e42" => :el_capitan
    sha256 "b250b4adcd147317bbfce32b0660cf9b64a35cac42a5df859b94f0dd8f322186" => :yosemite
    sha256 "8fb4b8ad763a6292d934a02c35bda05737ed30df5dc1feebc4375f90c75dc2af" => :mavericks
  end

  depends_on "wget"
  depends_on "autoconf" => :build

  def install
    bin.install "bin/php-build"
    share.install "share/php-build"
    man1.install "man/php-build.1"
  end

  def caveats; <<~EOS
    Tidy is enabled by default which will only work
    on 10.7. Be sure to disable or patch Tidy for
    earlier versions of OS X.
    EOS
  end

  test do
    system "php-build", "--definitions"
  end
end
