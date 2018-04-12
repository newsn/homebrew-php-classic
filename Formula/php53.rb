require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  desc "PHP Version 5.3"
  include AbstractPhpVersion::Php53Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 8

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "20cbaf7e2db0666931823a872f8f091b65a611639e27616548fa1eb146152474" => :sierra
    sha256 "6d3f4587f3a4f86aff533bab1cfda5e62e32a4b96f5068668a523d485b891690" => :el_capitan
    sha256 "8db8e778c8c3627a3396795fa028bc6c84d87b418c757c290b209c79c831cac6" => :yosemite
  end

  # build dependancy needed to fix issue #962
  depends_on "autoconf" => :build
  depends_on "re2c" => :build
  depends_on "flex" => :build
  depends_on "bison@2.7" => :build

  depends_on "libevent" if build.with? "fpm"

  option "disable-zend-multibyte", "Disable auto-detection of Unicode encoded scripts"

  def install
    # files need to be regenerated to fix issue #962
    Dir.glob("Zend/zend_{language,ini}_parser.{c,h}").each { |file| rm file }
    super
  end

  def install_args
    args = super
    args << "--enable-zend-multibyte" unless build.include? "disable-zend-multibyte"
    args << "--enable-sqlite-utf8"
  end

  def php_version
    "5.3"
  end

  def php_version_path
    "53"
  end

  # Previous Bison and 10.9+ patches, and multi-SAPIs patch (https://pecl.php.net/~jani/patches/multi-sapi.patch) applied
  patch do
    url "https://gist.githubusercontent.com/javian/6d63097c8c175045aa75ca48a6b8826b/raw/ca7bad287e3af72b83fbb5f7d03186b5da2e65ae/multi-sapi-5.3.29-homebrew.patch"
    sha256 "bdde5c0c1f9d2450d8d9d0a32882e1ee0008d8339eacf919e273e6f7937e7461"
  end

  # C++ 11 compatibility required for intl extension
  patch do
    url "https://gist.githubusercontent.com/ilovezfs/192a21d13ce0c40dcaa48617f1733097/raw/0856488df0e8190476d64ae68642670aebe8fbb3/gistfile1.txt"
    sha256 "8ed93dee54d82a1c48703c7b1348bd4cd61ed80f377d0d6d419cf38ff1274f42"
  end
end
