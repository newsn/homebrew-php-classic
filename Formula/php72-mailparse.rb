require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mailparse < AbstractPhp72Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.1.tgz"
  sha256 "42ee10de881a3739acf73ddef8800d80c3c57f70072f41bdb22e6e87ebc9cc62"
  head "https://github.com/php/pecl-mail-mailparse.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "37a0e6e11d25e3c28b8a04ab63b041e9926686dc9a970cbe6d5d58fc6e112ac6" => :high_sierra
    sha256 "bbe8b518017c4864a059b57031b6746495f3e19f057b89dbed466b4d30fcf871" => :sierra
    sha256 "0a8ab1dd08e705b857d36179a38dd93574d0d43ff4e03bdabd3a572d11923bbf" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
