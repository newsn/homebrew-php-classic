require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class WpCli < AbstractPhpPhar
  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org"
  url "https://github.com/wp-cli/wp-cli/releases/download/v1.5.0/wp-cli-1.5.0.phar"
  sha256 "f615d57957e66a09f57acc844a1fc5402e9fa581dcb387bbe1affc4d155baf9d"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2e66a7db517bcf01097bc81ceb3083e9d2bd4a03b8237516a96cc1c80337acc2" => :high_sierra
    sha256 "2e66a7db517bcf01097bc81ceb3083e9d2bd4a03b8237516a96cc1c80337acc2" => :sierra
    sha256 "2e66a7db517bcf01097bc81ceb3083e9d2bd4a03b8237516a96cc1c80337acc2" => :el_capitan
  end

  def phar_file
    "wp-cli-#{version}.phar"
  end

  def phar_bin
    "wp"
  end

  test do
    system "#{bin}/wp", "--info"
  end
end
