require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yac < AbstractPhp71Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-2.0.1.tar.gz"
  sha256 "c9357c9779a87370b53f719cfcf86b80258b119376c718fea336988b1d7354a0"
  head "https://github.com/laruence/yac.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f46ca54c3bb29ef1c40327429451b90e9d5ba9a0fc653815d5d176252acb9b4b" => :sierra
    sha256 "4afbeadf8ae8721f59b4d31dea32f0f47c25bd23c5c569f0b85b1fd793b5545b" => :el_capitan
    sha256 "1693ceb80f4469780d9684dbf687aa761c7fc74a03b63e31c20c24b91cde8493" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
