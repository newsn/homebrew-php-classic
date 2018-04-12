require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timecop < AbstractPhp55Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "81b9e085dbc4470112bf29b86b96817eb38572f9dfc5f69fd24f825d4654b03e" => :sierra
    sha256 "aef211aebb875007bc7ea52756943c57c12c37f18e8f4e5ed4e77664ea74e727" => :el_capitan
    sha256 "356d77d4e096a4a7616e6500a783716fe36bbfe8ca97c47591a867865d4614a6" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
