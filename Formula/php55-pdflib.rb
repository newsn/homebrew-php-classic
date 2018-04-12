require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pdflib < AbstractPhp55Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    rebuild 1
    sha256 "322556685eb89498e98137cd6f6254d87861c6cffda34c05276ed85a316c5c0f" => :el_capitan
    sha256 "eb2814f7649f9d60cc1a06c06fe340468d45ca2f448c7c943405ed1fe2b31f57" => :yosemite
    sha256 "c55d2cbcf938c3d56b0ec5f54602dda5041017ff45c9d082758820a0263100a7" => :mavericks
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
