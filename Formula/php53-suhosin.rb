require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Suhosin < AbstractPhp53Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "http://suhosin.org/stories/index.html"
  url "https://github.com/stefanesser/suhosin/archive/0.9.37.1.tar.gz"
  sha256 "322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    sha256 "44be63a8d2a39d138ed9092f9c1786db231a2d7ab41f4afbef0f2ca5dd259327" => :yosemite
    sha256 "e48ef4ad395a637c8ebf257e6f2eb21e81919e58ad62a40feaecfeda8586a4fc" => :mavericks
    sha256 "a4d580bc06edf867108898783303cba04e8eb22ddde920e1bec05f94b4369f22" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
