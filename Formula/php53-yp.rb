require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yp < AbstractPhp53Extension
  init
  desc "YP/NIS functions"
  homepage "https://pecl.php.net/package/yp"
  url "https://pecl.php.net/get/yp-1.0.1.tgz"
  sha256 "097fc6953c8faaf748acb34bb0c11ca81672f46fc19cd48f8a6c7da6714fa468"
  head "https://git.php.net:/repository/pecl/networking/yp.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0e88b41d2519240039e3422d07945439cf5d6fbfb8e22e48dc38950ae9f61452" => :el_capitan
    sha256 "9ac6465618573b9e424405bdbdb10d99bd82dc9106a2b799d56b3fe554f2fac3" => :yosemite
    sha256 "13825578f2c5eae0ad2d4254db7e286551fdd5f23c100edcb84bb5b54dd1d857" => :mavericks
  end

  def install
    Dir.chdir "yp-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yp.so"
    write_config_file if build.with? "config-file"
  end
end
