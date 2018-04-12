require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Sundown < AbstractPhp55Extension
  init
  desc "Sundown is a fast, robust Markdown parsing library for PHP5"
  homepage "https://pecl.php.net/package/sundown"
  url "https://pecl.php.net/get/sundown-0.3.11.tgz"
  sha256 "0a143a268f43f5f2a07988116acfa62671fad4636b84c0750327042f9cb8004f"

  bottle do
    cellar :any_skip_relocation
    sha256 "8f8bf68033ec67d4183dae5c450689097d7c3929e1bc640573c075c8434ceb4b" => :el_capitan
    sha256 "c82e085cbb7235f4d6ab3edf362c160a82b93a5a70300aa4da14e2b8fc0b765a" => :yosemite
    sha256 "bdb900cf66e707302c85b7b6c2c5a03e7e3f3bc8969470e56861889c13674c24" => :mavericks
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
