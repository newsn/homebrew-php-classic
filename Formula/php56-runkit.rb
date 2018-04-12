require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Runkit < AbstractPhp56Extension
  init
  desc "Extension to modify consts/functions/classes"
  homepage "http://php.net/manual/en/book.runkit.php"
  url "https://github.com/zenovich/runkit/archive/27f33f55eae4459448fc39fac49daba26bb6b575.tar.gz"
  version "5e179e9"
  sha256 "4b19ca9d4003eac6af51dd3b6b8e4365a74351a4fd248f2fe5c546b656a16a99"
  head "https://github.com/zenovich/runkit.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c0d7a13f1360dad822c5d5aa35dcc2bd384276e1781052a01561a47b5a8f22f7" => :el_capitan
    sha256 "db3102c6fff1cf573e36ee4fb8f4a384262f8f5da2a414a927b89a0446fb9be6" => :yosemite
    sha256 "ef74b266d44436d66f0d064eb06be8f74c34176c7244c205301d4722a027a290" => :mavericks
  end

  patch do
    url "https://github.com/zenovich/runkit/pull/71.diff"
    sha256 "3d81726baff080f8dbb0dfb7b7d56aba967532eb7a5092b810498381357ca26d"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
