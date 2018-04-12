require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Protobuf < AbstractPhp71Extension
  init
  desc "Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data."
  homepage "https://pecl.php.net/package/protobuf"
  url "https://pecl.php.net/get/protobuf-3.4.0.tgz"
  sha256 "510d8ea544e3d5fc44fa5d13f6db5dd7af3e292aee66f90409f95f4450414a71"

  bottle do
    cellar :any_skip_relocation
    sha256 "39007b7fd9bb8befd81271a8e169541badda12ee983d2c5ea101a4faa78e4f2e" => :high_sierra
    sha256 "681bb2c96fce7bf665a8ab88d87744e6a9153b7906d5c197b7a2d2b1b51ca21a" => :sierra
    sha256 "b767ead990d6ad139acb2b28d25bf4466b08c3639bb0db95b04c79946c2df57f" => :el_capitan
  end

  depends_on "protobuf"

  def install
    Dir.chdir "protobuf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
