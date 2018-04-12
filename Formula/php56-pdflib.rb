require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pdflib < AbstractPhp56Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    rebuild 1
    sha256 "299f6c188ad38226ccc05b2e695870674ed78ef679e07ccec8869560246a6a00" => :el_capitan
    sha256 "ed8b23039c3acf661f6982185faaad6d7e79069eb811cb65c5c6c719370b0e46" => :yosemite
    sha256 "b0f3cb3e4cb8becbe213909ef964d9b763f4fb19a37ee98b970b253e10f12839" => :mavericks
  end

  depends_on "pdflib-lite"

  def extension
    "pdf"
  end

  def install
    Dir.chdir "pdflib-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-pdflib=#{Formula["pdflib-lite"].opt_prefix}"
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file if build.with? "config-file"
  end
end
