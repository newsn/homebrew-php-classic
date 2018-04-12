require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Httpparser < AbstractPhp54Extension
  init
  desc "The C http parser from Ruby's Mongrel web server"
  homepage "https://github.com/dhotson/httpparser-php"
  url "https://github.com/dhotson/httpparser-php/archive/v0.1.0.tar.gz"
  sha256 "9ba699a116696bb3695b7bff7b5ffd2be4b5cbe6746d1814c628c141eb1ff381"
  head "https://github.com/dhotson/httpparser-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "20ce5ef613535a5cd3bf3891ffd29c4e61125945ac5dd2476f1330f67eaeab7a" => :yosemite
    sha256 "438050df4124f7dadb56d860639cd6402e9c6fc6aa5159bf4e4628877d038261" => :mavericks
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
