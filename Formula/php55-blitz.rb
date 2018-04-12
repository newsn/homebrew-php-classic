require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Blitz < AbstractPhp55Extension
  init
  desc "Blitz, the fasted template engine for PHP!"
  homepage "http://alexeyrybak.com/blitz/blitz_en.html"
  url "https://github.com/alexeyrybak/blitz/archive/0.9.1.tar.gz"
  sha256 "f2f9364509bf078e322f1cd8d6d2eece4cb73416a8a987f583464757fce79317"
  head "https://github.com/alexeyrybak/blitz.git"

  bottle do
    cellar :any
    sha256 "53ceca5be2bd5f2051d2915deb09a7c41df512b2c29837e664f8af67b69ea90f" => :yosemite
    sha256 "9741c130259f24b8fffc8fcd462a6e75bf61ba34b26c81262c163f93c6945d46" => :mavericks
    sha256 "e7b94ef3d7a2967a987cc7e70a4da2a09ce4adb01a16b935e8acddf334cf5f11" => :mountain_lion
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
