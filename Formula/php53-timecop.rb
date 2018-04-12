require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timecop < AbstractPhp53Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6d85509ff541d6b84adc62cda5ee7a864513f3610a5e9ae40317812a80df0b0f" => :sierra
    sha256 "314b96d39e6cdfd9f9fb761c44026b58b9e78f5bddaae83059a3be0105fccad2" => :el_capitan
    sha256 "ebfb6a75f16a6e82fd536b4d1eb162332d4b1a9cad3aa047fe0e402b7fce5ded" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
