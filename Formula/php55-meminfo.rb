require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Meminfo < AbstractPhp55Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.0.0",
    :revision => "0e4f884d02b9af4321d9b5121b017194047fb10e"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1494255329c7766faeb0bf33de627641543870af9722779098c5ee9eb0687266" => :high_sierra
    sha256 "a9913fbe80eb4fca58efd8eabe983a8dfa93c9bc828c9d12b46d9959658c2480" => :sierra
    sha256 "92244b6059229984c8e2dc8d8b7ef22e6986c0ba4642f455bcd3b2d5d78d764a" => :el_capitan
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
