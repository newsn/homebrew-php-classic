require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/56300713fe9f99084a52987d624579d92c2b1844/phpbrew"
  version "1.22.5"
  sha256 "84301c766146bdc04f10e8cb0e8c2aefeaf943b0bea24ca42318a8f12c0aee1b"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "2ce15446c6a4f2fdb042bd63f46ca7777ac805656f56e6548e8794b290c8bc12" => :sierra
    sha256 "cb58cd3acc3410cb205707933b25aab8ab5af48d27abbc0b05ddc0a6e9ea2af9" => :el_capitan
    sha256 "464458ea35517dbc0e7d9b85a95e3cbd7e02ca96009b013b661236ec14c3da8e" => :yosemite
  end

  depends_on "curl"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libevent"
  depends_on "libxml2"
  depends_on "icu4c"
  depends_on "mcrypt"
  depends_on "mhash"
  depends_on "pcre"
  depends_on "re2c"

  def phar_file
    "phpbrew"
  end

  def caveats; <<~EOS
    phpbrew is now installed!

    To start using it, please run
      `phpbrew init`

    You can change phpbrew home with PHPBREW_ROOT and PHPBREW_HOME env vars
    EOS
  end
end
