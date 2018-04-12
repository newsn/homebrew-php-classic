require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sundown < AbstractPhp56Extension
  init
  desc "Sundown is a fast, robust Markdown parsing library for PHP5"
  homepage "https://pecl.php.net/package/sundown"
  url "https://pecl.php.net/get/sundown-0.3.11.tgz"
  sha256 "0a143a268f43f5f2a07988116acfa62671fad4636b84c0750327042f9cb8004f"

  bottle do
    cellar :any_skip_relocation
    sha256 "23eaddecb7b40a1bf1942a2eb740cb4f9f87eeadd5730cbbdf6c64724c33a392" => :el_capitan
    sha256 "f69ad838a28ae3179159ce3244969a55ab842125694c5114ddfed1e8701715a1" => :yosemite
    sha256 "68c5667a14c8d84f3f4d36fd8b723bdf51784dce8e1da2cd7d2985b073f2049d" => :mavericks
  end

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file if build.with? "config-file"
  end
end
