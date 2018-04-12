class DrushAT5 < Formula
  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://ftp.drupal.org/files/projects/drush-7.x-5.9.tar.gz"
  sha256 "3acc2a2491fef987c17e85122f7d3cd0bc99cefd1bc70891ec3a1c4fd51dccee"

  bottle :unneeded

  keg_only :versioned_formula

  resource "Console_Table" do
    url "http://download.pear.php.net/package/Console_Table-1.1.3.tgz"
    sha256 "2c9ad601b2ee777c20ffe5b0c76a0ee66ad069e8753973208a42cebb9c1be8b1"
  end

  def install
    libexec.install Dir["*"]
    (libexec/"lib").install resource("Console_Table")
    bin.install_symlink libexec/"drush"
  end

  test do
    system "#{bin}/drush", "version"
  end
end
