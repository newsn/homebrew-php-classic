require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Uploadprogress < AbstractPhp53Extension
  init
  desc "An extension to track progress of a file upload."
  homepage "https://pecl.php.net/package/uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz"
  sha256 "30588b4589543bcf6371532546b1a8cee9da1086c206aca9f96ea1bd486bbab2"
  head "https://svn.php.net/repository/pecl/uploadprogress/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "985ecce7edb78d476ae8ba7f5a2c54d188623c4947f8f739c8dcb272045ef9ed" => :el_capitan
    sha256 "75c131e4267c55c954adca7e95cd6f89082d9d1aae752f0751d5827a7052ee1b" => :yosemite
    sha256 "c2eaa44d6b8242df807d6401cc76c6f4f82cf31329ce93000d07c5d1ba532e12" => :mavericks
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
