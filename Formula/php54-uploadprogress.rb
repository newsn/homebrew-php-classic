require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Uploadprogress < AbstractPhp54Extension
  init
  desc "An extension to track progress of a file upload."
  homepage "https://pecl.php.net/package/uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz"
  sha256 "30588b4589543bcf6371532546b1a8cee9da1086c206aca9f96ea1bd486bbab2"
  head "https://svn.php.net/repository/pecl/uploadprogress/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "4dd14748082e71946cde37e58bc49bd15692a980959eb3d8d8714b6e25e3cce3" => :el_capitan
    sha256 "23a22bdb09dffdf53e22c5d6d345a519d9038b33f6f48cdb09d23eaee3f032f2" => :yosemite
    sha256 "7154d2ebe7e9db4515f7e8eae8dcb4e104bc57e73d37046bd47542eea0986eb2" => :mavericks
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
