require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdiff < AbstractPhp54Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-1.5.2.tgz"
  sha256 "ebe72b887fcd2296f1e4032d476a8a463803ccfb0b34b403be8433daf3cfd81d"

  bottle do
    cellar :any
    sha256 "967ffeff504a5daf0ab0034f9373bf8ba02031812380e7e3057f38dbf99652e6" => :high_sierra
    sha256 "cf977fd09eb4efc4e6d87fffbc6c54d7f40ab5774d515e39447b767dbccdb3c0" => :sierra
    sha256 "d18543b0239b6f0197d7b23a8ddd187c62600b75d05335bd30a00a30465a260a" => :el_capitan
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
