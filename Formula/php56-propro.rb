require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "b951018d74bae189fce985b9e4ec447e569e65afa0a63bc511aeedeb498e084d" => :el_capitan
    sha256 "da5bc0e0d9f33662d4bdae92df4d16ffeab5525a0e5ac0d03e0224d89b2de7b4" => :yosemite
    sha256 "8f8b0b39061a74ba79beb67eb4f348eea808ad3aec9ea1f38e549bbd8e8e72e1" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
