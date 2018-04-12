require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ref < AbstractPhp70Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.4.4.tar.gz"
  sha256 "51da1e0625e2c89da05bdef5166e1046f5594870df4b0f6925eaa01b69925a9b"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "aa8cd93a90807813d335902996fdb91daee0a2d97d3807f7f5edf9a019db0d0c" => :high_sierra
    sha256 "deee0cf0a3176720017a97ba267149c7a1e94a7647df03cda30e514e463e0457" => :sierra
    sha256 "67c23e16d7f45ef5a43936eecbcea5e51760d25b7f0f88ef184bb661d1c3c8c0" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    <<~EOS
      This installs the older php-ref version #{version} which is no longer
      supported because PHP 7.0 support in php-ref discontinued.
    EOS
  end
end
