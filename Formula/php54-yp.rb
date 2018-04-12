require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yp < AbstractPhp54Extension
  init
  desc "YP/NIS functions"
  homepage "https://pecl.php.net/package/yp"
  url "https://pecl.php.net/get/yp-1.0.1.tgz"
  sha256 "097fc6953c8faaf748acb34bb0c11ca81672f46fc19cd48f8a6c7da6714fa468"
  head "https://git.php.net:/repository/pecl/networking/yp.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c6f0f890edc112b566069c6cdf0a31ab8ebbed2ec951867a9ef915e529481af9" => :el_capitan
    sha256 "439a2072ec5642d386508b31a08e737cbd55d1092e656dd31e691266250cf5e7" => :yosemite
    sha256 "4e883132376c4e741f58224ca224b9b43d6136618229231e7b44075123ce8641" => :mavericks
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
