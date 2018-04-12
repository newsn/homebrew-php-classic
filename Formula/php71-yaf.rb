require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yaf < AbstractPhp71Extension
  init
  desc "PHP framework similar to zend framework built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://github.com/laruence/yaf/archive/yaf-3.0.4.tar.gz"
  sha256 "06fb857c75fcaba8c0a77d0150c5789f24970614ddaeafa69a6c62b82312152a"
  head "https://github.com/laruence/yaf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e9dafad40c3af2160cd0cd01ac57ed0c68f5e7ea5fe9774e0fbed81fb72e3a4a" => :sierra
    sha256 "f3273abd8fd09cd3f346553e53eff981fe9f3fa7c4c9059d89b97ecd73455688" => :el_capitan
    sha256 "1908592b862ca4df6db18edb35afa6657ce65712d4405e77e6d93e4ba685984b" => :yosemite
  end

  depends_on "pcre"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
