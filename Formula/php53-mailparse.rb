require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mailparse < AbstractPhp53Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "df7f5e92f18ee215871418c623f8de78060a7843e87a94b9d3d995787573c364" => :el_capitan
    sha256 "54914865bfb51fdf6273115cabb9e7e6aceffa5a31cc5fa8ec1ba29bbc58dd7d" => :yosemite
    sha256 "08f81a01cc53d3edc4de139983a98a3525440859da542a68b82da9065feb6981" => :mavericks
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
