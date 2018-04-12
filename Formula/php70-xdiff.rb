require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdiff < AbstractPhp70Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-2.0.1.tgz"
  sha256 "b4ac96c33ec28a5471b6498d18c84a6ad0fe2e4e890c93df08e34061fba7d207"

  bottle do
    cellar :any
    sha256 "aa03a51880c43061bb5eaf0fadf9688b9163054903eb3e42677dbc4c76f5b422" => :high_sierra
    sha256 "f5c1b88e4684bc3a104fe0effc4126a7fcb74845f7f22f91d1a3c540c7f112a6" => :sierra
    sha256 "8a06da778c6c886d620522c3fcb3da09f1be0979a2a5ae7137077269162b53b4" => :el_capitan
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
