require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 25
  bottle do
    sha256 "653ad6a382ec789ba1c45f99757c12ec6215429edf2ddf1895bfcc6fb7930b8e" => :high_sierra
    sha256 "7caa82bcb126b18af1d65aa948217784e3a646ac45652f4922f1a1131cc6b829" => :sierra
    sha256 "674b40369efe5aaa039e9cee459eb45d46c21898ee75a5bd021112ff842612ae" => :el_capitan
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
