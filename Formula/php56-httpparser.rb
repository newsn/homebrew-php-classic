require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Httpparser < AbstractPhp56Extension
  init
  desc "The C http parser from Ruby's Mongrel web server"
  homepage "https://github.com/dhotson/httpparser-php"
  url "https://github.com/dhotson/httpparser-php/archive/v0.1.0.tar.gz"
  sha256 "9ba699a116696bb3695b7bff7b5ffd2be4b5cbe6746d1814c628c141eb1ff381"
  head "https://github.com/dhotson/httpparser-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6256f62505313f0387b2a8948473be280115e60c8740d0d5814de805be95f3d1" => :yosemite
    sha256 "cd3183077ace7009ef901c8aae1226552cf073c2d0fa7cfc838f864523ff22ea" => :mavericks
  end

  def extension
    "httpparser"
  end

  def install
    Dir.chdir "ext"

    ENV.universal_binary if build.universal?

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"

    prefix.install ["modules/httpparser.so"]
    write_config_file if build.with? "config-file"
  end
end
