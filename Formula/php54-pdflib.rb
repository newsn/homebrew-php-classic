require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pdflib < AbstractPhp54Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    rebuild 1
    sha256 "400c076180f2bb9875b9a36a8fb8d1dabeb3d674f39dcc4c2a05662a0315b6b4" => :el_capitan
    sha256 "71092c44164f8342542532b2f77aab4058d41736c1128ee85d257737a6e82840" => :yosemite
    sha256 "c3f54d44627396f0456c98f8266518acd7168ea619da694803546a2d11b7a8b1" => :mavericks
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
