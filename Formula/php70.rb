require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 19
  bottle do
    sha256 "c41732ead1b9c3fc3829ef46fddc38e617626846a56f0face3cd947b91dc6a10" => :high_sierra
    sha256 "524a493f9078c1b9c377151938c50c125ea0de13d7a11a2349bd203b497dd640" => :sierra
    sha256 "af9322832af5e4df0fb350e3332d4589785ec4702f5ff86321dfaee765adda64" => :el_capitan
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
