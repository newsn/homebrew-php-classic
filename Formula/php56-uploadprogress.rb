require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Uploadprogress < AbstractPhp56Extension
  init
  desc "An extension to track progress of a file upload."
  homepage "https://pecl.php.net/package/uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz"
  sha256 "30588b4589543bcf6371532546b1a8cee9da1086c206aca9f96ea1bd486bbab2"
  head "https://svn.php.net/repository/pecl/uploadprogress/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "c8df07b0a3a5a77a89fe3beac785b8ab20cf2010fc9b6f6d02df7c7b51327b62" => :el_capitan
    sha256 "149d696e78e1be37bf1d6ec58dc1d5aa22f52927c85c50d435b6baf53fd1f664" => :yosemite
    sha256 "3bd78efd9a7e512f7f3b0023087c3efca68aee89fd405639a54e63b26dcdeaed" => :mavericks
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
