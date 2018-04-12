require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Oauth < AbstractPhp70Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.0.tgz"
  sha256 "f223a166e82ea51a241c229c5788e19dcafd8a1886ce2b7635cae29cb33c4f0e"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "d06dd29e0cf1091c399e61abe37f4ef390b9d1e26d2a9892d1a9c7b395c1bf8c" => :el_capitan
    sha256 "325a10df83fa598c2618e372934d5f0e27897ed9602175fd208337d99fa18242" => :yosemite
    sha256 "fccd5ece9e155fc4105d4b80fc1d63c991d5fd37e020b6a14bbd9b4e282c9e8d" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
