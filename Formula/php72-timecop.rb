require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Timecop < AbstractPhp72Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a96c49ec9742bcbd5b055e91e3e7bcfe5997d16aada6247a3a2f637a5ab2ce3d" => :high_sierra
    sha256 "44ee44efc7ab11307089456d06677966517ab1dc4dd3fc5ffa28bb145d522a7d" => :sierra
    sha256 "c02aa7f12b4b3d152414ead6147baefd7989c59ab9132fa5bdb40b49673f299b" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
