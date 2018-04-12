require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Molten < AbstractPhp72Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "46d91dcb36e82a23c30261fdfc4b3db008b408460e81b05a310a04d21268b02b" => :high_sierra
    sha256 "780ceacfd7d98eafd6b9cf97521fd25f0146ebe8c3a9e8802bfc08f7190af15d" => :sierra
    sha256 "7887f32126d7e16ade7e196ca343661bf27ad219458c027db28876fba345e24e" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php72-redis"
  depends_on "php72-memcached"
  depends_on "php72-mongodb"

  def install
    args = []
    args << "--enable-zipkin-header=yes" if build.with? "zipkin"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/Molten.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
    ; Molten is transparency tool for application tracing it self module call.
    ; It trace php app core call and output zipkin/opentracing format trace log.
    ; Provides features about muliti trace sapi, multi sampling type,
    ; upload tracing status, module control and muliti sink type.
    ; get more details see: https://github.com/chuan-yun/Molten and then configure below
    [molten]
    molten.enable=1
    molten.sink_type=4
    molten.tracing_cli=0
    molten.sink_http_uri=http://127.0.0.1:9411/api/v1/spans
    molten.service_name=php_test
    molten.sampling_rate=1
    EOS
  end
end
