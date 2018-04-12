require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-4.0.0.phar"
  sha256 "e406841a9839179953998b3b1d2c3db848920c194c7204f3e603d7aead98bab9"

  bottle do
    cellar :any_skip_relocation
    sha256 "9c58331f8a6ee580b9abcacd9ceed0974758da1e05216e8c8fe5e6380815d98d" => :high_sierra
    sha256 "9c58331f8a6ee580b9abcacd9ceed0974758da1e05216e8c8fe5e6380815d98d" => :sierra
    sha256 "9c58331f8a6ee580b9abcacd9ceed0974758da1e05216e8c8fe5e6380815d98d" => :el_capitan
  end

  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "#{bin}/phpcpd", "--version"
  end
end
