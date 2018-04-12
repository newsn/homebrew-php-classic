require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mailparse < AbstractPhp71Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.2.tgz"
  sha256 "d81a6f8a48e43fca1c0f0d6c90d666830c24d584a23a60add43062aaf221843b"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fd3921eaa4f9551c114749f9d5f0c97ee51381c53aa56f32592b1d89ac5b43fa" => :high_sierra
    sha256 "c3e697db8c6b98d70530174a5a62a8246a75c6e198cfa5d7a07079680fad47e5" => :sierra
    sha256 "43fbdb1d45b2708d2658c9a5c9eb3769995df801e57622d8d357a6dd31389a48" => :el_capitan
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
