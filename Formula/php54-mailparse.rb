require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mailparse < AbstractPhp54Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "397ea346770adc425bdd578947168eb98312bdf93355765a4f3e1a0f74805ddb" => :el_capitan
    sha256 "e16ed984bd601c917b2b86b88d00584e870019b097a443b7e3c17bed608230dd" => :yosemite
    sha256 "87fff4a2f15a46f29da4a109a430e661288063824815719d375b2ecb6f0be36f" => :mavericks
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
