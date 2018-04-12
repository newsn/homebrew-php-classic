require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaml < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.3.0.tgz"
  sha256 "bf4696386fbd4e8435628d84ccb8c261c9e481888c7e1ce537cccceadcb57500"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "d6c00e6885fa9eeacab572804d595e08974df7ed469ebc6beaeb0d66e1275fed" => :sierra
    sha256 "4df418bb29cb99f1b2f127b087f76ab1d5534c003d90ddc120272859152ac703" => :el_capitan
    sha256 "49794f95575e8d584b2d3be279e6b91a10c5e5f4d085f61e89d37bffddd171cf" => :yosemite
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
