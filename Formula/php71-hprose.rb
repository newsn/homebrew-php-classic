require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Hprose < AbstractPhp71Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "4457db9ee70a4c75d52a35305f371ef92f29d018b63871332eeee7969314415f" => :high_sierra
    sha256 "33ce179017858e53ba98bc5dd6cd9d3ca02b3560c984f051c243fd9b4699b960" => :sierra
    sha256 "9a20d466d2c37a56b235a68de86ccaf54df5a1e9a265793170d8a595fdf45849" => :el_capitan
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
