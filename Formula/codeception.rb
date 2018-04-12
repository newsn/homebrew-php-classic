require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.6/codecept.phar"
  sha256 "9e31417fba27d9365d04d2dd8eb44468b60024c131279f62ea0b4f7828ca303c"

  bottle do
    cellar :any_skip_relocation
    sha256 "16f32533fa1b78e3b6953c6884aeeb5fa61f7af77ed4ada371aa360414b56283" => :high_sierra
    sha256 "16f32533fa1b78e3b6953c6884aeeb5fa61f7af77ed4ada371aa360414b56283" => :sierra
    sha256 "16f32533fa1b78e3b6953c6884aeeb5fa61f7af77ed4ada371aa360414b56283" => :el_capitan
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "#{bin}/codecept", "--version"
  end
end
