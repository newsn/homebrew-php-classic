require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Meminfo < AbstractPhp71Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.0.0",
    :revision => "0e4f884d02b9af4321d9b5121b017194047fb10e"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8939dcd7e56e444de19b18e0abfa9daa20332685ef1a3a716ada14dd06f20c96" => :high_sierra
    sha256 "4ba1645ace91fb471941650a4d0c4a537c3cad46982d95615286e1cae3d5d5ef" => :sierra
    sha256 "fb09de3b8693317380e8efd661d0182b5b6af013b220c15f721889bf756e8dd9" => :el_capitan
  end

  def install
    Dir.chdir "extension/php7" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
