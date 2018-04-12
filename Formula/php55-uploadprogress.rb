require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Uploadprogress < AbstractPhp55Extension
  init
  desc "An extension to track progress of a file upload."
  homepage "https://pecl.php.net/package/uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz"
  sha256 "30588b4589543bcf6371532546b1a8cee9da1086c206aca9f96ea1bd486bbab2"
  head "https://svn.php.net/repository/pecl/uploadprogress/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "144eec6bdc23c022dca87bd36acfaa8f00c084e74ff3ca4ded688355d39aa6b6" => :el_capitan
    sha256 "0c51658e04f191a62e72b086d4a933ebb6f950aa2c2417214005bafc718048b6" => :yosemite
    sha256 "e97dc80d95729d1a3af924efba074b217e21f2213f9138b4e57f1cbf4cedd7cd" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "uploadprogress-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                            phpconfig
    system "make"
    prefix.install "modules/uploadprogress.so"
    write_config_file if build.with? "config-file"
  end
end
