require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timecop < AbstractPhp71Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "992cf2a624fd9efc4ded88dba9a3aa54f2c098d1773ad74293e1e8754f417c08" => :high_sierra
    sha256 "15f07dcbc44ee031ed8ddec5be3b71755034f75360cd71a4bf18a5658efaa1c3" => :sierra
    sha256 "c0ff7b95e9b94173fd4b5ddcddb9907196fe7c98d8a9f8bf8e716fab9c536279" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
