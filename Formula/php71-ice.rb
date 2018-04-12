require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ice < AbstractPhp71Extension
  init
  desc "Ice for PHP"
  homepage "https://zeroc.com"
  url "https://github.com/zeroc-ice/ice/archive/v3.7.0.tar.gz"
  sha256 "809fff14a88a7de1364c846cec771d0d12c72572914e6cc4fb0b2c1861c4a1ee"

  bottle do
    sha256 "87ea1eff668a98dd5eb21da510cd6c52c7ff5abf6ceda9f7e3ae409864cf0957" => :high_sierra
    sha256 "87ea1eff668a98dd5eb21da510cd6c52c7ff5abf6ceda9f7e3ae409864cf0957" => :sierra
    sha256 "49d2c14c94a9264d890b56d4e92002aee90e1d1ddd32422df39813b7ce46299c" => :el_capitan
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
