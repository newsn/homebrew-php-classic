require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snappy < AbstractPhp55Extension
  init
  desc "Snappy Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-snappy"
  url "https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz"
  sha256 "4d1acaad08eacaa108618c6c765fe2d8da82c2f09f8996036e8bccb5438ebd61"
  version "0.1.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "704a94f8ec84752c3c15f7e2c30c93b233172ee73890e0e7d61675d8147b6f66" => :el_capitan
    sha256 "b338c75ce1c6d8d55d77fcb39ce908ae3b8ac5bd39825504313a38f800a53a3c" => :yosemite
    sha256 "457a1ff2451fb76bd254c79979482aec69bf2a85b6598f362673ba816543b8eb" => :mavericks
  end

  depends_on "snappy"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/snappy.so"
    write_config_file if build.with? "config-file"
  end
end
