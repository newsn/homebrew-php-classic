require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  desc "PHP Version 5.4"
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 7

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "79aed36ef77d28297cc19cca0efaa3751da9d71622e2d50aaca2b14cf83d3c45" => :sierra
    sha256 "196809210943191063bfe14afba0e6135ec8db8a6989914c3a130da11e7197f5" => :el_capitan
    sha256 "bc508ecba8234d7416957ca1da0e7bf455ab9f9bb0e19d257a83aa7de6eb23ec" => :yosemite
  end

  if build.with? "phpdbg"
    # needed to regenerate the configure script
    depends_on "autoconf" => :build
    depends_on "re2c" => :build
    depends_on "flex" => :build

    resource "phpdbg" do
      url PHPDBG_SRC_TARBALL
      sha256 PHPDBG_CHECKSUM[:sha256]
    end
  end

  def _install
    if build.with? "phpdbg"
      resource("phpdbg").stage buildpath/"sapi/phpdbg"

      # force the configure file to be rebuilt (needed to support phpdbg)
      File.delete("configure")
      system "./buildconf", "--force"
    end

    super
  end

  def php_version
    "5.4"
  end

  def php_version_path
    "54"
  end
end
