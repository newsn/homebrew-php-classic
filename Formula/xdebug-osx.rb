require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class XdebugOsx < Formula
  desc "Simple bash script to toggle xdebug on/off in OSX"
  homepage "https://github.com/w00fz/xdebug-osx"
  url "https://github.com/w00fz/xdebug-osx/archive/1.3.tar.gz"
  sha256 "db2c6c1835ff79fa05e655bf9425a011a743811d019a3fda894f085122f7eda4"
  head "https://github.com/w00fz/xdebug-osx.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6679e7c6dc326c214eabc53eec99dcc5a905de084f99780bac621ec403276cbc" => :sierra
    sha256 "6679e7c6dc326c214eabc53eec99dcc5a905de084f99780bac621ec403276cbc" => :el_capitan
    sha256 "b232419ad21873b7ac55745d6507678054da58a5bb8cf4f78ee70f38ad5326fd" => :yosemite
  end

  depends_on PhpMetaRequirement
  depends_on "php53-xdebug" if Formula["php53"].linked_keg.exist?
  depends_on "php54-xdebug" if Formula["php54"].linked_keg.exist?
  depends_on "php55-xdebug" if Formula["php55"].linked_keg.exist?
  depends_on "php56-xdebug" if Formula["php56"].linked_keg.exist?
  depends_on "php70-xdebug" if Formula["php70"].linked_keg.exist?
  depends_on "php71-xdebug" if Formula["php71"].linked_keg.exist?

  def install
    bin.install "xdebug-toggle"
  end

  def caveats; <<~EOS
    Signature:
      xdebug-toggle <on | off> [--no-server-restart]

    Usage:
      xdebug-toggle         # outputs the current status
      xdebug-toggle on      # enables xdebug
      xdebug-toggle off     # disables xdebug

    Options:
      --no-server-restart   # toggles xdebug without restarting apache or php-fpm

    EOS
  end

  test do
    system "#{bin}/xdebug-toggle"
  end
end
