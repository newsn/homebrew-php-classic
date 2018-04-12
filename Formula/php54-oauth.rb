require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Oauth < AbstractPhp54Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "483fe32a0f471f463795a777a11f3ac5e56c15fc5005a071295ef9c1fa344048" => :el_capitan
    sha256 "f5579f00e39e98e17c09348be620ad4be855222a59d1f84c2089ffd2958b5ecd" => :yosemite
    sha256 "a6c49635d75468847271d841e2d7ae4432a7771aa05b48a4d4fe456256e3a0c8" => :mavericks
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
