require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yac < AbstractPhp72Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-2.0.1.tar.gz"
  sha256 "c9357c9779a87370b53f719cfcf86b80258b119376c718fea336988b1d7354a0"
  head "https://github.com/laruence/yac.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "a5519f2217286359c36cef7a1c1e566cefe7a1c36e6598ccdbb6c3331073db04" => :high_sierra
    sha256 "4b1dbe5787e1a519ebca6309aed8d608593d0d9a280306c9affd4ea24e11d5fd" => :sierra
    sha256 "b299985fea984f17f08317f8b43c2f2ccb318b067f8fcad25b7e777f17b3732e" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
