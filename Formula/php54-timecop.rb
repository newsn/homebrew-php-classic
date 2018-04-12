require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timecop < AbstractPhp54Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ea4e97674fbadf9edc07540f7d1d595ec67c85cfc083b0f367c23eae6a007c67" => :sierra
    sha256 "8b4ac2ef717c38382c62aafa83f0374a68d8304b1ae3e2874eb2b13af7a958ac" => :el_capitan
    sha256 "9036e5d36c52ebfea60ff47c2d4f7ede81a4b70381ccb6a6461564c330137572" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
