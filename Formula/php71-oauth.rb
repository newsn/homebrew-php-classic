require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Oauth < AbstractPhp71Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.2.tgz"
  sha256 "87ce1a5d585f439f0ead2683f2f7dca76d538df9143da681978356b5e1c6e8e8"
  head "https://github.com/php/pecl-web_services-oauth.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7938f1e1d5fa8023e23f518c1d9fb5b767253b74a962f3a87a4c6ab04713b0cd" => :el_capitan
    sha256 "429fd54dfdeb181e043e27203cc15404940642e690c23f8a37dda40d11a7d614" => :yosemite
    sha256 "e35f011fa224a45d0f4c2835cc27b0443219351a9ea3911a4a88f9347db78f80" => :mavericks
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
