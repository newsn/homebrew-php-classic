require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Translit < AbstractPhp71Extension
  init
  desc "transliterates non-latin character sets to latin"
  homepage "https://github.com/derickr/pecl-translit"
  url "https://github.com/derickr/pecl-translit/archive/RELEASE_0_6_2.tar.gz"
  sha256 "863ba3793d09776c309ae1a46af2826f8acf855db10ba8d976716ec6ab2ea3a5"

  bottle do
    cellar :any_skip_relocation
    sha256 "e84b6fca0a8fc7067918fdc3bfb37a19f70503773cf763b85e6b37108b9041fc" => :high_sierra
    sha256 "023ec598f1e4d854a2a55e0ae74887cfeacc33d4eed45fd545d4f9aee03e552f" => :sierra
    sha256 "67dbf0c95674c0a10c13842b2a8c0930a7b9026412f92bb1e1b718ee785a5773" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/translit.so"
    write_config_file if build.with? "config-file"
  end
end
