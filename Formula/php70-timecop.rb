require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timecop < AbstractPhp70Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6c438f288612c13efae200327ec04da17c03336f65c07e8ecf092c4f18e6c46c" => :high_sierra
    sha256 "78ce65c9756002fcf87c0b4adf570a7f6b4e062c71c16395a6bf7b784becc3af" => :sierra
    sha256 "67006cb6d428237235032f4064a4f3d7101a74c69d748deeeaaa68a8745f2e58" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
