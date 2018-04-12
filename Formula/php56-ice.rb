require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ice < AbstractPhp56Extension
  init
  desc "Ice for PHP"
  homepage "https://zeroc.com"
  url "https://github.com/zeroc-ice/ice/archive/v3.7.0.tar.gz"
  sha256 "809fff14a88a7de1364c846cec771d0d12c72572914e6cc4fb0b2c1861c4a1ee"

  bottle do
    sha256 "1093bd1c095cd1258a293f0d120aefe328ee55d41c57ca796dd16231284d7032" => :high_sierra
    sha256 "1093bd1c095cd1258a293f0d120aefe328ee55d41c57ca796dd16231284d7032" => :sierra
    sha256 "6e853b6eb6e6ba05b31ce9d3ae4bb19defb28b20c949aa3bd1acaa7d89152ece" => :el_capitan
  end

  depends_on "ice"

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      include_path="#{opt_prefix}"
      EOS
  rescue StandardError
    nil
  end

  def install
    args = [
      "V=1",
      "install_phpdir=#{prefix}",
      "install_phplibdir=#{prefix}",
      "OPTIMIZE=yes",
      "ICE_HOME=#{Formula["ice"].opt_prefix}",
      "ICE_BIN_DIST=cpp",
      "PHP_CONFIG=#{Formula[php_formula].opt_bin}/php-config",
    ]

    Dir.chdir("php")
    system "make", "install", *args
    write_config_file if build.with? "config-file"
  end
end
