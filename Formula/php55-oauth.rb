require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Oauth < AbstractPhp55Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "f1427e75c4b888b0b11da3f344fafe3e56e2d1e7b5dd1ad5227bda2eb072cba4" => :el_capitan
    sha256 "6dd6b7f81aba3dd6684af4c45765bb0ab9c9d1569ed4d62855484926260cdfea" => :yosemite
    sha256 "a56e4615373777b80de1b6d61e666680ac071511836e2249273ec499f9b7045b" => :mavericks
  end

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
