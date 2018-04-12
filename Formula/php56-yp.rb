require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yp < AbstractPhp56Extension
  init
  desc "YP/NIS functions"
  homepage "https://pecl.php.net/package/yp"
  url "https://pecl.php.net/get/yp-1.0.1.tgz"
  sha256 "097fc6953c8faaf748acb34bb0c11ca81672f46fc19cd48f8a6c7da6714fa468"
  head "https://git.php.net:/repository/pecl/networking/yp.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "febf9badc50c6ac4af6e5117fcf6ba3f1da6e72642a5a6904ec0d59a6fc3d425" => :el_capitan
    sha256 "d0731083f5d69a9b560196eb62d6ac85288d62593fb2cf58bbda7cdbc5ef4e86" => :yosemite
    sha256 "441d7704b8913c9adb48056f6bd4432f04fa064e7ae01cc7e372e7fd186feb44" => :mavericks
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
