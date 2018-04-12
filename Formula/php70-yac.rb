require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yac < AbstractPhp70Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-2.0.1.tar.gz"
  sha256 "c9357c9779a87370b53f719cfcf86b80258b119376c718fea336988b1d7354a0"
  head "https://github.com/laruence/yac.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a5856bffa00b481024c36c738e4322ed7162d4888f7dcd2de7af2ef87b620d1c" => :sierra
    sha256 "6f8d9fc3463f01359aab9f3d105dbb32988dddd5b6d147385d7530a4ab9e827f" => :el_capitan
    sha256 "a726f09d9008b453842a8a6d269d63b57ac078458f2fedb54962aef4e733685b" => :yosemite
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
