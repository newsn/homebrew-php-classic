require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yrmcds < AbstractPhp55Extension
  init
  desc "Memcached/yrmcds client extension for PHP5"
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.2.tar.gz"
  sha256 "5a77840db23d5b93b86c3ef9507e10894be85cd43e7283af80b6bbacd4b08b69"
  head "https://github.com/cybozu/php-yrmcds.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "87dd6b7c9721a303ed528c72e0ae2dac4627767f0d40e1d40a051c9e20c88a11" => :el_capitan
    sha256 "bf719ca5b6ac08446e51d7bb1c7eaad1d1964198b1f0ad8183ed54f9027f7ef8" => :yosemite
    sha256 "18a25840672b041d1909519baccb7d6ae65f0a323ebf5a9bb164603c896617ae" => :mavericks
  end

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
