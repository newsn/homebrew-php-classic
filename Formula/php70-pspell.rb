require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 18

  bottle do
    sha256 "ec8c63a15fa0855ecdb186d8280f201066ceb381e495f342b6e8e5b4aed11524" => :high_sierra
    sha256 "6f80107f855c245d6855075e6ba5ada0d94a8715cf3525e839d806eab7b8890d" => :sierra
    sha256 "9548842dcc21224407d137fe440ebb904a1334c23a44b1fb554b12bceb194b1a" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end
