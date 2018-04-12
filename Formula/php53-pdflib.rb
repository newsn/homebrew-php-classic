require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pdflib < AbstractPhp53Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    sha256 "d8d3fb05afe13610eb2698b82a2191d0974578217a8ca948503d08e3ca2d52ea" => :el_capitan
    sha256 "47030bbc60ffdea53f29428931481b78655c663ec1d19243f11c5a0a0112e0f5" => :yosemite
    sha256 "0d39ad9d624240fe81b01af3564a59998ab626404316992660d7c7aa7f276220" => :mavericks
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
