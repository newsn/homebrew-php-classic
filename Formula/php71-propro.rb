require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Propro < AbstractPhp71Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-2.0.1.tar.gz"
  sha256 "0f310cf0ea11950ff48073537b87b99826ad653c8405556fa42475504c263b64"
  head "https://github.com/m6w6/ext-propro.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ee43f93e73451ac5c10fc1cbd1d045eeac9219a8fe585a0af95379c45c6bf0c1" => :sierra
    sha256 "2df0a9f2cdc51295f65a5e805ce9cdd861035c6b848f5d8ab0d92bef7ac8f5bb" => :el_capitan
    sha256 "2f083814ad44e24f8592f38b0a68321909dd28b0106c54b1ba323b9121c1c7cb" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
