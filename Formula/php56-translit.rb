require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Translit < AbstractPhp56Extension
  init
  desc "transliterates non-latin character sets to latin"
  homepage "https://github.com/derickr/pecl-translit"
  url "https://github.com/derickr/pecl-translit/archive/RELEASE_0_6_2.tar.gz"
  sha256 "863ba3793d09776c309ae1a46af2826f8acf855db10ba8d976716ec6ab2ea3a5"

  bottle do
    cellar :any_skip_relocation
    sha256 "00bd8c0428a0785eee31b0f741f208129127d3b174078cdf493f429afce0ef01" => :high_sierra
    sha256 "1a933b68ec78ed6b467f143b22b3a5aabef65eafb949023e7d742bcfa6cc9323" => :sierra
    sha256 "7ac9d8be631f0c9e4205351a723131ed003bf5fb35c323adbf918682777d1754" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/translit.so"
    write_config_file if build.with? "config-file"
  end
end
