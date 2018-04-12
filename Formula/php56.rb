require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 9

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "9b29babdf7ff17d9ca18d8b9b6e18adf35be5a2bfff5cb2d48276496f5f19be4" => :high_sierra
    sha256 "bd9b5ec915ce2597c4b271a9c3cdf98df79cd2cad41d1cb824c32dcd6b372742" => :sierra
    sha256 "05d46bf97248a65496d4f4b7ab4071a3624aa113fe5ced2786c5188a2821cd5a" => :el_capitan
  end

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end
end
