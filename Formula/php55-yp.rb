require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yp < AbstractPhp55Extension
  init
  desc "YP/NIS functions"
  homepage "https://pecl.php.net/package/yp"
  url "https://pecl.php.net/get/yp-1.0.1.tgz"
  sha256 "097fc6953c8faaf748acb34bb0c11ca81672f46fc19cd48f8a6c7da6714fa468"
  head "https://git.php.net:/repository/pecl/networking/yp.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2a1a747dc492ad8f9bb91d2a0b8f27d6d89883a9b23b4656aa87e13122d43f50" => :el_capitan
    sha256 "3c3d39412230643937340af07c248be14f8ebc485df438703f4612b708148308" => :yosemite
    sha256 "644c0387f6538e9082a7834546313520cbe7fb64c0a615e9d107e96dcb0b3729" => :mavericks
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
