require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mailparse < AbstractPhp70Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.2.tgz"
  sha256 "d81a6f8a48e43fca1c0f0d6c90d666830c24d584a23a60add43062aaf221843b"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "923347391f09977576d7c3aa7d106bdeb7076c413f7d534b3554e9d311d6d27e" => :high_sierra
    sha256 "0cdef239df0e04b9252b99b9970a198c53fd134a594f452032a6604e84c430e5" => :sierra
    sha256 "c3ec9f3ddb636a422a9c9b4218b43567e6231bd3cd6823ec7a22401bf0923edf" => :el_capitan
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
