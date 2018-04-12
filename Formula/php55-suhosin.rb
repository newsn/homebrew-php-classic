require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Suhosin < AbstractPhp55Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "https://suhosin.org/stories/index.html"
  url "https://github.com/sektioneins/suhosin/archive/0.9.38.tar.gz"
  sha256 "c02d76c4e7ce777910a37c18181cb67fd9e90efe0107feab3de3131b5f89bcea"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5984e59ca273602bd2e093c35446f06b39416f9c807d2c541c7083eb41319284" => :sierra
    sha256 "890e718666bc34512f823017206d700de4c782fd93e212e48df7f270fd34b053" => :el_capitan
    sha256 "110aca03a135155a687663cf51cfc109d2468fcee6dc130fc723afe69586525d" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
