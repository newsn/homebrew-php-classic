require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Oauth < AbstractPhp72Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.2.tgz"
  sha256 "87ce1a5d585f439f0ead2683f2f7dca76d538df9143da681978356b5e1c6e8e8"
  head "https://github.com/php/pecl-web_services-oauth.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "f0d34a2f2fd40489c73d18e0896f8296609f9b782ca112c9cac388ec3f9a7ad1" => :sierra
    sha256 "643e3d4a8b7efa9bbd234261fe05e43e55e24f26e752ee7059bef74113241531" => :el_capitan
    sha256 "8081f48fbc836b615bb2c18c3dc6681df119bb5dd391819898837c54ba638884" => :yosemite
  end

  depends_on "pcre"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
