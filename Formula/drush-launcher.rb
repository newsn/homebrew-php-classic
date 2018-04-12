require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class DrushLauncher < AbstractPhpPhar
  desc "A small wrapper around Drush for your global $PATH."
  homepage "https://github.com/drush-ops/drush-launcher"
  url "https://github.com/drush-ops/drush-launcher/releases/download/0.5.0/drush.phar"
  sha256 "ef8556bad7162a59a14e688e154e5b1564702c6a341522b06a1339b7d395cd18"

  bottle :unneeded

  def phar_file
    "drush.phar"
  end

  def phar_bin
    "drush"
  end

  test do
    system "#{bin}/drush", "--drush-launcher-version"
  end

  conflicts_with "drush", :because => "because both provide a 'drush' executable"
end
