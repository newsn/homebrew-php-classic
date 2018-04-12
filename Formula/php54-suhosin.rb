require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Suhosin < AbstractPhp54Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "https://suhosin.org/stories/index.html"
  url "https://github.com/sektioneins/suhosin/archive/0.9.38.tar.gz"
  sha256 "c02d76c4e7ce777910a37c18181cb67fd9e90efe0107feab3de3131b5f89bcea"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9bb8a882b45eda9d0511804f0b11499e96fe77b3ee4729295c8fcab2d6c18386" => :sierra
    sha256 "0ba428c797f98c09afffc7e5dc2e1eed1d073848381721618a2c4db8bd1e2085" => :el_capitan
    sha256 "8ad5fafb4407ac08e40a92076921fecd5a3a02c6e8deb6e6ec2def54ea88a28f" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
