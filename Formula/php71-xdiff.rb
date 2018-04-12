require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdiff < AbstractPhp71Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-2.0.1.tgz"
  sha256 "b4ac96c33ec28a5471b6498d18c84a6ad0fe2e4e890c93df08e34061fba7d207"

  bottle do
    cellar :any
    sha256 "a0eac1ecc8dde4025887148837ea9e70365e46cf859ec1164eefa7a3ef94ca9c" => :high_sierra
    sha256 "3d760613e1f0994c4b159724e560752761f303afb56e953266d6be0f5e0c6c74" => :sierra
    sha256 "7d67a9b71fdb33c2f507f640f4a57e53fa208b2f0f4f26217bbaf38bf43397df" => :el_capitan
  end

  depends_on "libxdiff"

  def install
    Dir.chdir "xdiff-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xdiff.so"
    write_config_file if build.with? "config-file"
  end
end
