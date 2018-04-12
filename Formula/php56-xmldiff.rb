require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xmldiff < AbstractPhp56Extension
  init
  desc "XML diff and merge"
  homepage "https://pecl.php.net/package/xmldiff"
  url "https://pecl.php.net/get/xmldiff-0.9.2.tgz"
  sha256 "60d7d7fde2ebb695ae2cb26803153ad07a6146e0d70c102b3403131c86177550"

  bottle do
    cellar :any
    sha256 "374681741f75a3363f7d8cea373be80e01ffe154628d9008d495ec99b43d21db" => :el_capitan
    sha256 "cc6131f5c71e45c9832dc6178233cbee131e69356dadf7d6857ae4dc13166dba" => :yosemite
    sha256 "e5d57fa37bc8e5f4db4c37e6bb07b518ac253f7b6a4f3083a50b3089bc60bac4" => :mavericks
  end

  def install
    Dir.chdir "xmldiff-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file if build.with? "config-file"
  end
end
