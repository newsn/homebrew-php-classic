require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mailparse < AbstractPhp55Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4fc0f6eaa4697c4bd824c4d2f8f27fd529894bfb7841c6a55905f177ffb0dd90" => :el_capitan
    sha256 "f6276307439884d2c24ed76aac530db8ef661f3c47efbdb0b6f564ea187b6e83" => :yosemite
    sha256 "f3ae4a293bfee6590fa59cbef714340d126ae4d218208e5eabf744f81a174e7f" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
