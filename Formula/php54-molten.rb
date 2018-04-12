require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Molten < AbstractPhp54Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  revision 1
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bc1f72827f53c2f795f73f388de6f393e22df6cc7ab14b05664b37714ce3b402" => :high_sierra
    sha256 "7a26c847f986a2cbccb9c4ecaace5408abd37980c3b5b33dc7930360aad5ca39" => :sierra
    sha256 "4ca9d479177edadead009490db2afd448eb537968ff0ea662e08b56f422ab2ac" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php54-redis"
  depends_on "php54-memcached"
  depends_on "php54-mongodb"

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
