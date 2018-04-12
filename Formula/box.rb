require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.5/box-2.7.5.phar"
  sha256 "28b4b798ad4dcf8fbf9cd68aaff495d4bbeaec4363f5f319a222829d9b6abdfe"

  bottle do
    cellar :any_skip_relocation
    sha256 "cd2baa189580996769badeae4cee7139f8206edf6183979fdc70f34f544315b5" => :sierra
    sha256 "539441dc92d8af21c95045483e9169616f20a80d1192fe2c6fc8f0789ca697fb" => :el_capitan
    sha256 "cd2baa189580996769badeae4cee7139f8206edf6183979fdc70f34f544315b5" => :yosemite
  end

  def phar_file
    "box-#{version}.phar"
  end

  def phar_wrapper
    <<~EOS
      #!/usr/bin/env bash
      set -- $* && [ "${0##*/} $1" == "box build" ] && PHARRW="-d phar.readonly=Off"
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off $PHARRW #{libexec}/#{@real_phar_file} $*
    EOS
  end

  test do
    system "#{bin}/box", "--version"
  end
end
