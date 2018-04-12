require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-4.0.1.phar"
  sha256 "626b7320984ecd400dee8da9ebd10c3527084f698de640d9bfd5d03564743582"

  bottle do
    cellar :any_skip_relocation
    sha256 "b2b9754efa4fc9a19a13fe8a26ae8887fa3db70ad5e46a10f78383a4e51f5c97" => :high_sierra
    sha256 "b2b9754efa4fc9a19a13fe8a26ae8887fa3db70ad5e46a10f78383a4e51f5c97" => :sierra
    sha256 "b2b9754efa4fc9a19a13fe8a26ae8887fa3db70ad5e46a10f78383a4e51f5c97" => :el_capitan
  end

  def phar_file
    "phploc-#{version}.phar"
  end

  test do
    system "#{bin}/phploc", "--version"
  end
end
