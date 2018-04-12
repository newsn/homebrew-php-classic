require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mailparse < AbstractPhp56Extension
  init
  desc "Mailparse is an extension for parsing and working with email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://svn.php.net/repository/pecl/mailparse/trunk"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "46ca4601372bc4570a234ac2928b7629d2bd5ba782232fa7fd1636b23806d860" => :el_capitan
    sha256 "d15e7d8c3ee19d8d113e9321d6ede95423b1b0d34f19fc203b151e160315885b" => :yosemite
    sha256 "850ac4b9d2354f723fc2bea963c6a35826e615b664c2167ac9b7340aa0e8d777" => :mavericks
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
