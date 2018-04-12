require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Blitz < AbstractPhp70Extension
  init
  desc "Blitz, the fasted template engine for PHP!"
  homepage "http://alexeyrybak.com/blitz/blitz_en.html"
  url "https://github.com/alexeyrybak/blitz/archive/0.10.2-PHP7.tar.gz"
  version "0.10.2"
  sha256 "202752e825ae035989cbcb0094ef7ec8e0791d0741d36c4b14077b155310597f"
  head "https://github.com/alexeyrybak/blitz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cf33325cc71842745749567a9c1a16332d9052584af0515520f81bcb8c2479be" => :el_capitan
    sha256 "0bdd1ceb0bd42cd09747352ce295524b4b0be1fba9597d495cf91061888f0cc1" => :yosemite
    sha256 "59726c08379b64a1c2af98fd8888abd713610f3ce8fbf351b840b09fbedde7c7" => :mavericks
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
