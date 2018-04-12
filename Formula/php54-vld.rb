require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Vld < AbstractPhp54Extension
  init
  desc "Provides functionality to dump the internal representation of PHP scripts"
  homepage "https://pecl.php.net/package/vld"
  url "https://pecl.php.net/get/vld-0.13.0.tgz"
  sha256 "f61fe6501b6f30cf5628b7fd0e2c41185bb9bfac96b765c8b967a8ba01f7bf8b"
  head "https://github.com/derickr/vld.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b7aed08abfa315e56cfdf7f8ed6b561a84b78bb313a9bfbe3c7180f9966d6812" => :el_capitan
    sha256 "2e7c274e993998f844dc9e2d6f47ebb06ade06b69a3980dbf702507de04eb6a8" => :yosemite
    sha256 "96c3afc0924021796ae2dd099d851aee39ecc0d8838a4d2f3c6ad4da44f19d75" => :mavericks
  end

  def install
    Dir.chdir "vld-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/vld.so"
    write_config_file if build.with? "config-file"
  end
end
