require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "5dcbd449278fdb1b862c8c9a6e92a9beb3318242ffae3f221aca6ec9c3bbfc1b" => :high_sierra
    sha256 "efe79977aec101ab93155bee6ad0b9de7ae67c6f15ff1181064bce33908ea637" => :sierra
    sha256 "9f14cb740deef2d3ee311928613d428c8c443d6f92511af5700e67b7305edfb0" => :el_capitan
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
