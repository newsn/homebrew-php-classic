require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Blitz < AbstractPhp54Extension
  init
  desc "Blitz, the fasted template engine for PHP!"
  homepage "http://alexeyrybak.com/blitz/blitz_en.html"
  url "https://github.com/alexeyrybak/blitz/archive/0.9.1.tar.gz"
  sha256 "f2f9364509bf078e322f1cd8d6d2eece4cb73416a8a987f583464757fce79317"
  head "https://github.com/alexeyrybak/blitz.git"

  bottle do
    cellar :any
    sha256 "09e94586052678a9406c1a9abbba387a1a1478cb49adffcdd6a246074c4aa668" => :yosemite
    sha256 "d3d75353cef5a608a0c74a8fa428b4564f993f1a09de33de56f6053b242206c7" => :mavericks
    sha256 "5d363f483adda5ea00eea8660328fb944a312ae70eb5f6f09670df5f5fd12cb1" => :mountain_lion
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
