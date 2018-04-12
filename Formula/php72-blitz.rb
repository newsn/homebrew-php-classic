require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Blitz < AbstractPhp72Extension
  init
  desc "Blitz, the fasted template engine for PHP!"
  homepage "http://alexeyrybak.com/blitz/blitz_en.html"
  url "https://github.com/alexeyrybak/blitz/archive/0.10.2-PHP7.tar.gz"
  version "0.10.2"
  sha256 "202752e825ae035989cbcb0094ef7ec8e0791d0741d36c4b14077b155310597f"
  head "https://github.com/alexeyrybak/blitz.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "50f8f59cf0c7d347bb8a9ce8c8b2b53a57948af9d1c526be68559cb771bba09f" => :high_sierra
    sha256 "80350cd4d4615c61dbe4a0737d9418a72b60bacc858e44a51eff90478d3f4d85" => :sierra
    sha256 "788fde917414c82cf22ad9240a4ad67667e0b84f4d7e13faf18d74923fcd67b4" => :el_capitan
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/blitz.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      blitz.auto_escape=0
      blitz.check_recursion=1
      blitz.comment_close="*/"
      blitz.comment_open="/*"
      blitz.enable_alternative_tags=1
      blitz.enable_callbacks=1
      blitz.enable_comments=0
      blitz.enable_include=1
      blitz.enable_php_callbacks=1
      blitz.lower_case_method_names=1
      blitz.path=""
      blitz.php_callbacks_first=1
      blitz.remove_spaces_around_context_tags=1
      blitz.scope_lookup_limit=0
      blitz.tag_close="}}"
      blitz.tag_close_alt="-->"
      blitz.tag_open="{{"
      blitz.tag_open_alt="<!--"
      blitz.throw_exceptions=0
      blitz.var_prefix="$"
      blitz.warn_context_duplicates=0
    EOS
  end
end
