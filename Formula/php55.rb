require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php55 < AbstractPhp
  init
  desc "PHP Version 5.5"
  bottle do
    sha256 "6cd6b2a0b6d273c3e677c6d080ca1e9cfd5d2dcd79336fbf4bcf9d9c77276622" => :sierra
    sha256 "74f04bf0826bd5127b11655e3d3002a4f576c0680dfdc38b6e43d6c50dcfe2f6" => :el_capitan
    sha256 "5ac78f2cef906b0634da2eb3bdf2b5d076b60a9f406f2022555a6db409e54577" => :yosemite
  end

  include AbstractPhpVersion::Php55Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 12

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

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
    "5.5"
  end

  def php_version_path
    "55"
  end
end
