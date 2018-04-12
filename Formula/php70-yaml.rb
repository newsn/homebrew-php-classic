require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaml < AbstractPhp70Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0.tgz"
  sha256 "ef13ff56c184290c025a522bf9ae2e1b3ecc8543c3a5161dd02adec90897a221"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  bottle do
    sha256 "fa457fa9ee16a2715f62c4d13d6f4dc90581bbdbbde4f17620046250a2e5331b" => :sierra
    sha256 "be5654c6e7e572255ad770a23b98b8e82fbaa192ca813f9478c538f5be36e19a" => :el_capitan
    sha256 "e076dcf6f5b3834a063787fa0ad280fb270d61ae1c88c77dbd34071ef6cffa45" => :yosemite
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
