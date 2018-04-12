require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdocumentor < AbstractPhpPhar
  init
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.9.0/phpDocumentor.phar"
  version "2.9.0"
  sha256 "c7dadb6af3feefd4b000c19f96488d3c46c74187701d6577c1d89953cb479181"

  bottle do
    cellar :any_skip_relocation
    sha256 "9acbf5cef29ca455818fc58dd44baa9d724067e45268bcc01d3acef1a6677fd9" => :sierra
    sha256 "e9c30434edf6f8432a7afc0439c0584ecd0559c163dcd4f3d0466a0561fe8eef" => :el_capitan
    sha256 "80c05a819a837da97b3e72c52859864cd637be7ea54610c2a315922bdde5ce50" => :yosemite
    sha256 "7cd8bef75d61785af68117a53073d76d82cd6e4e0bc097ef54178e7b7493b012" => :mavericks
  end

  def phar_file
    "phpDocumentor.phar"
  end

  def phar_bin
    "phpdoc"
  end

  test do
    system "phpdoc", "--version"
  end
end
