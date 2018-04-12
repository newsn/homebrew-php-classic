require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Oauth < AbstractPhp53Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7417fde959d04540a902b06be46a39c180e8aed87b400a20f1eae6a0dad1495b" => :el_capitan
    sha256 "00756eb2418bb99e2812eae70f4f3ffa985d8c3a37674ceea1a9ee0947f0ebcd" => :yosemite
    sha256 "e2d67cca3733ae0b36d4e5c37dae3a895b96f2bed65d1336d8a8552a558ef464" => :mavericks
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
