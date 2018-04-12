require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Meminfo < AbstractPhp56Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.0.0",
    :revision => "0e4f884d02b9af4321d9b5121b017194047fb10e"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf334ee751b496a7fd2b2b629b8c629be98c0a7a2d6185dba3153aee043b1b1d" => :high_sierra
    sha256 "4d58e87dfb4e018de1920948f5a4547afa4df353463257560b71c160337fabed" => :sierra
    sha256 "26cdb8c3eb9ebe82e94fd3b3c2d1c9a0ba0f89b778d55c5f391619f6cc977be8" => :el_capitan
  end

  def install
    Dir.chdir "extension/php5" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
