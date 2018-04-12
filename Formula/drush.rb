require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.15.tar.gz"
  sha256 "24f6ed26b5e7e21ce81760244d11f8e7057d496b36a51406de0364215ed32aa7"
  head "https://github.com/drush-ops/drush.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f9d39cb0b3239695df92437ce65c0d270a62d2249ad842aeeaf0c5ecc83575dc" => :high_sierra
    sha256 "5524b5b91b5d0594e8e9eb33b402ca7b440411e88a0b96cd9f35f915a57145ac" => :sierra
    sha256 "d4ac66d73a71dde73a6940838934bf7cb9a86c3e7e49a9db7bd567d4e96f660d" => :el_capitan
  end

  depends_on PhpMetaRequirement
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?

  def install
    composer_install

    prefix.install_metafiles
    libexec.install Dir["*"]
    (bin+"drush").write <<~EOS
      #!/bin/sh

      export ETC_PREFIX=${ETC_PREFIX:=#{HOMEBREW_PREFIX}}
      export SHARE_PREFIX=${SHARE_PREFIX:=#{HOMEBREW_PREFIX}}

      exec "#{libexec}/drush" "$@"
    EOS
    bash_completion.install libexec/"drush.complete.sh" => "drush"
  end

  test do
    system "#{bin}/drush", "version"
  end
end
