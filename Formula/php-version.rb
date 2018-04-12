class PhpVersion < Formula
  desc "stupid simple PHP version management"
  homepage "https://github.com/wilmoore/php-version#simple-php-version-switching"
  url "https://github.com/wilmoore/php-version/archive/0.12.1.tar.gz"
  sha256 "e5f54ee62d6f7f9397e6cac2affd4c7f8b0e9d68deb5d7db267f40483a2b9352"
  head "https://github.com/wilmoore/php-version.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5f84023f8062da9241288fef4ede271667bef142a59b3937eb57a3ae7c2ef5b9" => :sierra
    sha256 "cc1894acc47186d18f2e05cbacf8076f97de73bca6aaee10681b8098d52ab176" => :el_capitan
    sha256 "35ca805abab44acf0ed0f6a30292c3080c312a89f3f4eed0a93b83ac50351398" => :yosemite
  end

  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

        source $(brew --prefix php-version)/php-version.sh && php-version 5

      It is recommended that you install versions of PHP via homebrew as depicted below:

        brew install php56
        brew unlink php56

      Type `php-version --help` for more configuration options.
    EOS
  end

  test do
    assert File.exist?("#{prefix}/php-version.sh")
  end
end
