require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yrmcds < AbstractPhp54Extension
  init
  desc "Memcached/yrmcds client extension for PHP5"
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.2.tar.gz"
  sha256 "5a77840db23d5b93b86c3ef9507e10894be85cd43e7283af80b6bbacd4b08b69"
  head "https://github.com/cybozu/php-yrmcds.git"

  patch do
    url "https://gist.githubusercontent.com/KonstantinKuklin/4cebe58997e2152cdc35/raw/09a5c4cd1a2739d2d9e0e38338d4e9d01058f914/patch_php-yrmcds_mac.patch"
    sha256 "c523d4f6d40370d60244b30e9139c7120289f654f9758cd2e8f5b868d40f0316"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/yrmcds.so"
    write_config_file if build.with? "config-file"
  end
end
